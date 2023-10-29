
using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided, Distributions, Random, Pipe
using BrowseTables
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
#                                   INTRODUCTION
##############################################################################
#=
Why focusing on loops? The most immediate reason is loops itself. However, timing issues in this respect are easily spotted. Rather, the main reason is that we usually break down tasks into functions. 
If the main function ultimately contains a loop, then you compound timing problems of other functions. So, assessing just an evaluation in isolation would make us believe that the timing differences are negligible.
However, this is misleading, as the issue is that maybe you're main operation will end up incurring that problem multiple times. =#

##############################################################################
#                                   NUMBERS DON'T ALLOCATE
##############################################################################
"""
Numbers, accessing ONE element of an array, and ranges do not affect the number of memory allocations.
It takes more time to access a single element of a vector, but this is negligible.
"""

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


"""
Accessing more than one item of an array allocates memory. 
It allocates memory to create a temporary copy of the vector.
"""

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



"""
what if you like working with vectors? 
There are two options.
"""

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




##############################################################################
#                                   DISPLAYING RESULTS
##############################################################################
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