
using DataFrames,BenchmarkTools, LoopVectorization, FastBroadcast, Formatting, Distributions, Random, Pipe, StaticArrays, Strided
using BrowseTables
browse(x) = open_html_table(x)


###########################################
#               CREATE FAKE DATA
###########################################

Random.seed!(123) # Setting the seed

nr_firms_per_industry                         = 500
nr_industries                                 = 4_000 # same as 10 years with 400 industries
distribution_revenues                         = Pareto(log(4,5)) #80-20 rule
revenues(distribution, nr_firms_per_industry) = rand(distribution, nr_firms_per_industry) 

function info_industries(distribution_revenues, nr_firms_per_industry) 
    ind = Int64[]
    rev = Float64[]
        for i in 1:nr_industries
            append!(ind, repeat([i], nr_firms_per_industry))
            append!(rev, revenues(distribution_revenues, nr_firms_per_industry))
        end
    return ind,rev
end


dff = @pipe info_industries(distribution_revenues, nr_firms_per_industry) |> 
             DataFrame([:industry, :revenue] .=> _)
dfg = groupby(dff, :industry)


## ADD MISSING VALUES
nr_missing                  = Int(floor(0.05 * nr_firms_per_industry * nr_industries))
index_missing               = rand(1:(nr_firms_per_industry * nr_industries), nr_missing)

allowmissing!(dff, :revenue)
    dff[index_missing, :revenue] .= missing

## ADD EXPORTERS
nr_exporters_per_industry  = 100
proportion_exporting       = 0.3
dff.isexporter            .= false  
sort!(dff,[:industry,:revenue], rev=true)


function add_exporters!(dfg, nr)    
    for i in eachindex(dfg)
        dfg[i][1:nr, :isexporter] .= true
    end
end
add_exporters!(dfg, nr_exporters_per_industry)

dff.exports = @. dff.revenue * proportion_exporting * rand() / 0.5 



###########################################
#               FUNCTION TO BE CONSIDERED `FOO`
###########################################
foo(x,a) = x / a * 100 + x^2 / a^3 * 100 + log(x) + a^2 * exp(x)
foo(x,a) = x / a * 100 

#AUXILIAR
function pre_allocate(x)
    eltype(x) isa Union ?
    (c = Vector{Union{Float64,Missing}}(undef,length(x))) :
    (c = Vector{Float64}(undef,length(x)))
    return c
end



#INITIALIZE DATAFRAME FOR STORING RESULTS
dfr = DataFrame(seconds = Float64[], case = String[])

function store_result!(dff, dfg, case_name, share)
    push!(dff.seconds, @belapsed(transform(dfg, :revenue => share => :share)))
    push!(dff.case, case_name)
end


##############################################################################
#                                   STANDARD LOOPS
##############################################################################

function share(x)
    a = (sum ∘ skipmissing)(x)
    c = foo.(x,(a))
    return c
end
store_result!(dfr, dfg, "standard", share)



function share(x)
    c = pre_allocate(x)
    a = (sum ∘ skipmissing)(x)
    @. c = foo(x,(a))
end
store_result!(dfr, dfg, "inline", share)

function share(x)
    c = pre_allocate(x)
    a = (sum ∘ skipmissing)(x)
          for i in eachindex(x)
            c[i] = foo(x[i],a)
          end
    return c
end
store_result!(dfr, dfg, "inline 2", share)


function share(x)
    c = pre_allocate(x)
    a = (sum ∘ skipmissing)(x)
    @.. c = foo(x,(a))
end
store_result!(dfr, dfg, "FastBroadcast", share)

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
store_result!(dfr, dfg, "@turbo skipmissing loop", share)


function share(x)
    c = pre_allocate(x)
    a = (sum ∘ skipmissing)(x)
    @turbo for i in eachindex(x)
            c[i] = foo(x[i],a)
           end
    return c
end
store_result!(dfr, dfg, "@turbo loop", share)

function share(x)
    a = (sum ∘ skipmissing)(x)    

    foo2(x) = foo(x,a)
    c = vmapnt(foo2,x)
    return c
end
store_result!(dfr, dfg, "vmapnt", share)


function share(x)    
    a = (sum ∘ skipmissing)(x)    
    
    foo2(x) = foo(x,a)
    c = vmap(foo2,x)
    return c
end
store_result!(dfr, dfg, "vmap", share)

function share(x)    
    a = (sum ∘ skipmissing)(x)    
    foo2(x) = foo(x,a)

    c = map(foo2,x)
    return c
end 
store_result!(dfr, dfg, "map", share)


function share(x)
    a = (sum ∘ skipmissing)(x)
    
    c = pre_allocate(x)
    foo2(x) = foo(x,a)
    vmapnt!(foo2,c,x)
    return c
end
store_result!(dfr, dfg, "vmapnt!", share)

function share(x)    
    a = (sum ∘ skipmissing)(x)

    foo2(x) = foo(x,a)
    c = pre_allocate(x)
    vmap!(foo2,c,x)
    return c
end
store_result!(dfr, dfg, "vmap!", share)

######################################
####        ITERATING over GROUPS
######################################
dff1 = dropmissing(dff, :revenue, view=true)
dfg  = groupby(dff1, :industry)


function iter(func, dfg, pre_alloc, col) 
    parent(dfg)[!, pre_alloc] = similar(parent(dfg)[!, col])    
    @Threads.threads for i in eachindex(dfg)
        func(dfg[i][!, pre_alloc], dfg[i][!, col], dfg[i])
    end
end

function share(c,x,df)
    a = sum(x)
    for j in 1:nrow(df)
        c[j] = foo(x[j], a)
    end
end

#iter(share, dfg, :cal, :revenue) 
push!(dfr.seconds, @belapsed(iter($share, $dfg, :cal, :revenue)))
push!(dfr.case, "group iteration")


function share(c,x,df)
    a = sum(x)
    @turbo for j in 1:nrow(df)
        c[j] = foo(x[j], a)
    end
end
push!(dfr.seconds, @belapsed(iter($share, $dfg, :cal, :revenue)))
push!(dfr.case, "group iteration - turbo")



function share(c,x,df)
    a = sum(x)
    @inbounds for j in 1:nrow(df)
        c[j] = foo(x[j], a)
    end
end
push!(dfr.seconds, @belapsed(iter($share, $dfg, :cal, :revenue)))
push!(dfr.case, "group iteration - @inbounds")



function share(c,x,df)
    a = sum(x)
    @.. c = foo(x, a)
end
push!(dfr.seconds, @belapsed(iter($share, $dfg, :cal, :revenue)))
push!(dfr.case, "group FastBroadcast")


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