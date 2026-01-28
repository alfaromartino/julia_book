############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
# necessary packages for this file
using Random
 
############################################################################
#
#			SECTION: "MACROS AS A MEANS FOR OPTIMIZATIONS"
#
############################################################################
 
############################################################################
#
#			USE OF MACROS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

function foo(x)
    x1 = view(x, x .> 0.7)
    x2 = view(x, x .< 0.5)
    x3 = view(x, 1:500)
    x4 = view(x, 501:1_000)

    x1, x2, x3, x4
end
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

@views function foo(x)
    x1 = x[x .> 0.7]
    x2 = x[x .< 0.5]
    x3 = x[1:500] 
    x4 = x[501:1_000]

    x1, x2, x3, x4
end
 



############################################################################
#
#			MACROS APPLIED IN FOR-LOOPS
#
############################################################################
 
####################################################
#	@inbounds as an example
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

function foo(x)
    output = 0.    

    @inbounds for i in eachindex(x)
                  a       = log(x[i])
                  b       = exp(x[i])
                  output += a / b
    end

    return output
end
@ctime foo($x)
 



# remark: alternative application of @inbounds
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

function foo(x)
    output = 0.    

    for i in eachindex(x)
        @inbounds a       = log(x[i])
        @inbounds b       = exp(x[i])
                  output += a / b
    end

    return output
end
@ctime foo($x)
 



############################################################################
#
#			MACROS COULD BE APPLIED AUTOMATICALLY OR DISREGARDED BY THE COMPILER
#
############################################################################
 
####################################################
#	redundant macros
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output += log(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

function foo(x)
    output = 0.

    @inbounds for i in eachindex(x)
        output += log(x[i])
    end

    return output
end
@ctime foo($x)
 



####################################################
#	disregarded macro 
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(2_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = if (200_000 > i > 100_000)
                        x[i] * 1.1
                    else
                        x[i] * 1.2
                    end
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(2_000_000)

function foo(x)
    output = similar(x)

    @simd for i in eachindex(x)
        output[i] = if (200_000 > i > 100_000)
                        x[i] * 1.1
                    else
                        x[i] * 1.2
                    end
    end

    return output
end
@ctime foo($x)
 
