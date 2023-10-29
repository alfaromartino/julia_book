
using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided, Distributions, Random, Pipe, BrowseTables
#using DataFrames, BenchmarkTools, BrowseTables, Distributions, Random, Pipe
browse(x) = open_html_table(x)



##############################################################################
#                                   FAKE DATA
##############################################################################
Random.seed!(123)                           # Setting the seed for reproducibility

nr_firms_per_industry                       = 500
nr_industries                               = 40 # same as 10 years with 400 industries
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


dff = @pipe info_industries(distribution, nr_firms_per_industry) |> 
             DataFrame([:industry, :revenue] .=> _)
dfg = groupby(dff, :industry)

####### ADD EXPORTERS #########
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


####### ADD MISSING VALUES to EXPORTS ########
nr_missing                  = Int(floor(0.05 * nr_firms_per_industry * nr_industries))
index_missing               = rand(1:(nr_firms_per_industry * nr_industries), nr_missing)

allowmissing!(dff, :exports)
    dff[index_missing, :exports] .= missing



##############################################################################
#                       DATAFRAME FOR STORING TIMING
##############################################################################
dfr = DataFrame(seconds = Float64[], case = String[])

function store_result!(dff, dfg, case_name, share)
    push!(dff.seconds, @belapsed(transform(dfg, :revenue => share => :share)))
    push!(dff.case, case_name)
end


##############################################################################
#                                   AUXILIARS
##############################################################################

function pre_allocate(x)
    eltype(x) isa Union ?
    (c = Vector{Union{Float64,Missing}}(undef,length(x))) :
    (c = Vector{Float64}(undef,length(x)))
    return c
end


# to test a complex function 
foo(x,y) = x / y * 100 + (x^2 + y^2) / y + log(x) + y * exp(x)



##############################################################################
#                                   NUMBERS DON'T ALLOCATE
##############################################################################

function test()    
    for _ in 1:100
        a = 1
    end
end
@btime test()

function test(x)    
    for _ in 1:100
    a = x[1]
    end
end

array = [1,2,3]
@btime test($array)


function test()
    for _ in 1:100
    a = 1:1
    a[1] + a[1]
    end
end

array = [1,2,3]
@btime test(array)

#this is important for the next, not itself


##############################################################################
#                                   ARRAYS ALLOCATE
##############################################################################
function test()
    for _ in 1:100
        a = 1
        b = 2

        a + b
    end
end
@benchmark test()

function test(x)
    for _ in 1:100
        a = x[[1,2]]        # it allocates TWO temporary vectors: `x[[1,2]]` and `[1,2]`

        a[1] + a[2]
    end
end

array = [1,2,3]
@benchmark test($array)



##############################################################################
#                                   VIEWS
##############################################################################
### first we can reduce allocation with ranges
function test(x)
    for _ in 1:100
        a = x[1:2]          # it allocates ONE temporary vector: `x[1:2]` only

        a[1] + a[2]
    end
end

array = [1,2,3]
@benchmark test($array)


# Now, let's focus on the allocation `x[1:2]`. The solution that applies to every case is using views of slices.
# Notice that `view` doesn't solve the allocation of `[1,2]`. It only creates views of slices.
# A `view` actually minimizes allocations, and sometimes has to allocate memory. 
function test(x)
    for _ in 1:100
        a = view(x, 1:2)

        a[1] + a[2]
    end
end
array = [1,2,3]
@benchmark test($array)

# you also have available the macros `@view` and `@views` to create views of slices. They perform completely different operations.
# `@view` is equivalent to `view(x, 1:2)`, while `@views` identifies slices in some code and replaces with views of them.

# I'm not a big fan of macros, although their use is inevitable. Sometimes, they lead to unexpected behaviors. See XXXXXX in particular for particular bugs you could introduce by using `@views`.
function test(x)
    for _ in 1:100        
        a = @view x[1:2]
        b = @view x[2:3]

        a[1] + a[2]
    end
end
array = [1,2,3]
@benchmark test($array)

@views function test(x)
    for _ in 1:100
        a = x[1:2]
        b = x[2:3]

        a[1] + a[2]
    end
end
array = [1,2,3]
@benchmark test($array)
#`@views` is more general since it'd apply to \textit{any} slice that appears in the code.


# Using Slices of Arguments allocate, and `@views` take care of that
# Recall that the goal is to think that these functions will be used in main loops 
@views function test(x)
    for _ in 1:100
        a = x[1:2]
        b = x[2:3]

        a[1] + a[2]
    end
end
array = [1,2,3,4,5]
@benchmark test($array[1:3])


##############################################################################
#                                   Static Arrays
##############################################################################
using StaticArrays


function test(x)
    c = 0
    for _ in 1:100
        a = x[SVector(1,2)]
        b = x[SVector(2,3)]

        c = a[1] + b[2]
    end    
    return c
end
array  = [1,2,3]
Sarray = SVector{length(array),Int64}(array)
@benchmark test(Sarray)

sv(x)  = SVector{length(x),eltype(x)}(x)
sv2(x) = SVector{length(x),eltype(x)}(x)

function test(x)
    c = 0
    for _ in 1:100
        a = x[sv(1:2)]
        b = x[sv(2:3)]

        c = a[1] + b[2]
    end    
    return c
end
array  = [1,2,3]
Sarray = SVector{length(array),Int64}(array)
@benchmark test(Sarray)


function test(x)
    c = 0
    for _ in 1:100
        a = x[1:2]
        b = x[2:3]

        c= a[1] + b[2]
    end
    return c
end
nt = ntuple(i->i, 3)
@benchmark test(nt)






##############################################################################
#                                   GENERATORS
##############################################################################

array1 = rand(2)
array2 = rand(2)
repetitions = 1_000_000

function test1(x,y,repetitions; pre_alloc = Vector{Float64}(undef,repetitions))
    for i in 1:repetitions
        gen(x,y) = [foo(x[i],y[i]) for i in eachindex(x,y)]     # a generator, not a tuple
        pre_alloc[i] = sum(gen(x,y))
    end    
    return pre_alloc
end
display("test1")
display(@benchmark test1($array1, $array2, $repetitions))
#testit(array1, array2)



function test2(x,y,repetitions; pre_alloc = Vector{Float64}(undef,repetitions))    
    gen = (foo(x[j],y[j]) for j in eachindex(x,y))
    for i in 1:repetitions        
        pre_alloc[i] = sum(gen)
    end    
    return pre_alloc
end
display("test2")
display(@benchmark test2($array1, $array2, $repetitions))


function test3(x,y,repetitions; pre_alloc = Vector{Float64}(undef,repetitions))
    for i in 1:repetitions        
        pre_alloc[i] = sum(foo.(x,y))
    end    
    return pre_alloc
end
display("test3")
display(@benchmark test3($array1, $array2, $repetitions))

function test3(x,y,repetitions; pre_alloc = Vector{Float64}(undef,repetitions), pre_alloc2 = similar(x))
    for i in 1:repetitions
       @turbo pre_alloc2 .= foo.(x,y)
       pre_alloc[i] = sum(pre_alloc2)
    end    
    return pre_alloc
end
display("test3")
display(@benchmark test3($array1, $array2, $repetitions))

array1 = rand(500)
array2 = rand(500)


#= with these values wont matter
array1 = rand(1_000_000)
array2 = rand(1_000_000)
repetitions = 2

while here could matter, which makes a difference relative to static arrays
array1 = rand(500)
array2 = rand(500)
repetitions = 100_000
=#



##############################################################################
#                                   DISPLAYING RESULTS
##############################################################################
#=
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
=#