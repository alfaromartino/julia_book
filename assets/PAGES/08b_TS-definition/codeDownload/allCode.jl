############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git") #uncomment if you don't have the package installed
using FastBenchmark
    
############################################################################
#   AUXILIARS FOR DISPLAYING RESULTS
############################################################################
# you can alternatively use "println" or "display"
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x)


############################################################################
#
#			START OF THE CODE
#
############################################################################
 
############################################################################
#
#           A DEFINITION
#
############################################################################
 
x = [1, 2, 3]                  # `x` has type `Vector{Int64}`

@ctime sum($x[1:2])            # type stable
 



x = [1, 2, "hello"]            # `x` has type `Vector{Any}`

@ctime sum($x[1:2])            # type UNSTABLE
 
############################################################################
#
#           TYPE STABILITY WITH SCALARS
#
############################################################################
 
function foo(x,y)
    a = (x > y) ?  x  :  y

    [a * i for i in 1:100_000]
end

foo(1, 2)           # type stable   -> `a * i` is always `Int64`
@ctime foo(1, 2)
 



function foo(x,y)
    a = (x > y) ?  x  :  y

    [a * i for i in 1:100_000]
end

foo(1, 2.5)         # type UNSTABLE -> `a * i` is either `Int64` or `Float64`
@ctime foo(1, 2.5)
 
############################################################################
#
#           TYPE STABILITY WITH VECTORS
#
############################################################################
 
x1::Vector{Int}     = [1, 2, 3]

sum(x1)             # type stable
 



x2::Vector{Int64}   = [1, 2, 3]

sum(x2)             # type stable
 



x3::Vector{Float64} = [1, 2, 3]

sum(x3)             # type stable
 



x4::BitVector       = [true, false, true]

sum(x4)             # type stable
 



x                  = [1, 2, 3]

sum(x)             # type stable
@ctime sum(x)
 



x5::Vector{Number} = [1, 2, 3]

sum(x5)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Number`
@ctime sum(x5)
 



x6::Vector{Any}    = [1, 2, 3]

sum(x6)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Any`
@ctime sum(x6)
 
