############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
    # uncomment if you don't have the package installed
using FastBenchmark
    

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Random, StatsBase
 
############################################################################
#
#			INTRODUCTION TO SIMD (SINGLE INSTRUCTION, MULTIPLE DATA)
#
############################################################################
 
############################################################################
#
#			SIMD IN BROADCASTING
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(1_000_000)

foo(x) = 2 ./ x
@ctime foo($x)
 
