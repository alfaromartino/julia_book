
using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided, Distributions, Random, Pipe
using BrowseTables
browse(x) = open_html_table(x)


#CREATE FAKE DATA
Random.seed!(123) # Setting the seed

nr_firms_per_industry                       = 1_000_000
nr_industries                               = 2 # same as 10 years with 400 industries
distribution                                = Pareto(log(4,5))
revenue(distribution,nr_firms_per_industry) = rand(distribution, nr_firms_per_industry) #80-20 rule

function info_industries(distribution, nr_firms_per_industry) 
    ind = Int64[]
    rev = Float64[]
        for i in 1:nr_industries
            append!(ind, repeat([i], nr_firms_per_industry))
            append!(rev, revenue(distribution,nr_firms_per_industry))
        end
    return ind,rev
end

nr_missing = 500
index_missing = rand(1:nr_firms_per_industry, nr_missing) 


dff = @pipe info_industries(distribution, nr_firms_per_industry) |> 
             DataFrame([:industry, :revenue] .=> _)
allowmissing!(dff, :revenue)
dff.revenue[index_missing] .= missing

dfg = groupby(dff, :industry)


foo(x,a) = x / a * 100 + x^2 / a^2 * 100 + log(x)


#INITIALIZE DATAFRAME FOR STORING RESULTS
dfr = DataFrame(seconds = Float64[], case = String[])

function store_result!(dff, dfg, case_name)
    push!(dff.seconds, @belapsed(transform(dfg, :revenue => share => :share)))
    push!(dff.case, case_name)
end

list = copy(dfg[1][:,:revenue])
function store_result!(dff, list, case_name, share)
    push!(dff.seconds, @belapsed(share($list)))
    push!(dff.case, case_name)
end


function pre_allocate(x)
    eltype(x) isa Union ?
    (c = Vector{Union{Float64,Missing}}(undef,length(x))) :
    (c = Vector{Float64}(undef,length(x)))
    return c
end

##############################################################################
#                                   STANDARD LOOPS
##############################################################################


function share(x)
    a = (sum ∘ skipmissing)(x)
    c = foo.(x,(a))
    return 2
end
store_result!(dfr, list, "standard", share)


function share(x)
    c = pre_allocate(x)
    a = (sum ∘ skipmissing)(x)
    @. c = foo(x,(a))
end
store_result!(dfr, list, "inline", share)

function share(x)
    c = pre_allocate(x)
    a = (sum ∘ skipmissing)(x)
        for i in eachindex(x)
            c[i] = foo(x[i],a)
           end
    return c
end
store_result!(dfr, list, "inline 2", share)


function share(x)
    a = (sum ∘ skipmissing)(x)
    d = copy(x)

    index_nomiss = (!ismissing).(d)
    c = convert(Vector{Float64}, d[index_nomiss])
        
    @turbo for i in eachindex(c) 
        c[i] = foo(c[i],a)
    end

    d[index_nomiss] = c
    return d
end
store_result!(dfr, list, "@turbo skipmissing loop", share)


function share(x)
    c = pre_allocate(x)
    a = (sum ∘ skipmissing)(x)
    @turbo for i in eachindex(x)
            c[i] = foo(x[i],a)
           end
    return c
end
store_result!(dfr, list, "@turbo loop", share)

function share(x)
    a = (sum ∘ skipmissing)(x)    

    foo2(x) = foo(x,a)
    c = vmapnt(foo2,x)
    return c
end
store_result!(dfr, list, "vmapnt", share)


function share(x)    
    a = (sum ∘ skipmissing)(x)    
    
    foo2(x) = foo(x,a)
    c = vmap(foo2,x)
    return c
end
store_result!(dfr, list, "vmap", share)

function share(x)    
    a = (sum ∘ skipmissing)(x)    
    foo2(x) = foo(x,a)

    c = map(foo2,x)
    return c
end
store_result!(dfr, list, "map", share)


function share(x)
    a = (sum ∘ skipmissing)(x)
    
    c = pre_allocate(x)
    foo2(x) = foo(x,a)
    vmapnt!(foo2,c,x)
    return c
end
store_result!(dfr, list, "vmapnt!", share)

function share(x)    
    a = (sum ∘ skipmissing)(x)

    foo2(x) = foo(x,a)
    c = pre_allocate(x)
    vmap!(foo2,c,x)
    return c
end
store_result!(dfr, list, "vmap!", share)


##############################################################################
#                                   THREADS
##############################################################################


function share(x)
    c = pre_allocate(x)
    a = (sum ∘ skipmissing)(x)
    @Threads.threads for i in eachindex(x)
            c[i] = foo(x[i],a)
           end
    return c
end
store_result!(dfr, list, "@Threads.threads", share)


function share(x)
    a = (sum ∘ skipmissing)(x)
    d = copy(x)

    index_nomiss = (!ismissing).(d)
    c = convert(Vector{Float64}, d[index_nomiss])
        
    @tturbo for i in eachindex(c) 
        c[i] = foo(c[i],a)
    end

    d[index_nomiss] = c
    return d
end
store_result!(dfr, list, "@tturbo skipmissing loop", share)


function share(x)
    c = pre_allocate(x)
    a = (sum ∘ skipmissing)(x)
    @tturbo for i in eachindex(x)
            c[i] = foo(x[i],a)
           end
    return c
end
store_result!(dfr, list, "@tturbo loop", share)



function share(x)    
    a = (sum ∘ skipmissing)(x)

    foo2(x) = foo(x,a)
    c= vmapntt(foo2,x)
    return c
end
store_result!(dfr, list, "vmapntt", share)

function share(x)    
    a = (sum ∘ skipmissing)(x)

    foo2(x) = foo(x,a)
    c = vmapt(foo2,x)
    return c
end
store_result!(dfr, list, "vmapt", share)

function share(x)    
    a = (sum ∘ skipmissing)(x)

    foo2(x) = foo(x,a)
    c = pre_allocate(x)
    vmapntt!(foo2,c,x)
    return c
end
store_result!(dfr, list, "vmapntt!", share)

function share(x)    
    a = (sum ∘ skipmissing)(x)

    foo2(x) = foo(x,a)
    c = pre_allocate(x)
    vmapt!(foo2,c,x)
    return c
end
store_result!(dfr, list, "vmapt!", share)


###RESULT IN MILISECONDS
function rescale_time(result, digits; format=false) 
#    printx(x,N) = sprintf1("%.$(N)f",x)
    a = result * 1e3  # to translate time into miliseconds (ms) use 1e3
    a = round(a, digits=digits)
    (format == true) && (a = format(a))    

    return a
end

output = copy(dfr)

output.ms = rescale_time.(output.seconds, 1)
output.rate = round.(output[:, :ms] ./ output[output.case.=="standard",:ms] .* 100, digits=2)
sorted3  = sort(output, :seconds)

browse(sorted3)