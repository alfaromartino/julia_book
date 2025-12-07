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
 
using Random, StatsBase
 
############################################################################
#
#			SIMD (SINGLE INSTRUCTION, MULTIPLE DATA)
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo!(x)
    for i in eachindex(x)
        x[i] = 2 * x[i]
    end
end
@ctime foo!($x)
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo_unrolled!(x)
    for i in 1:4:length(x)-3
        x[i]   = 2 * x[i]
        x[i+1] = 2 * x[i+1]
        x[i+2] = 2 * x[i+2]
        x[i+3] = 2 * x[i+3]
    end
end
@ctime foo_unrolled!($x)
 
############################################################################
#
#			ANTICIPATING WHEN SIMD WILL BE APPLIED IS HARD
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
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @simd for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo!(x)
    for i in eachindex(x)
        x[i] = 2 / x[i]
    end
end
@ctime foo!($x)
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo!(x)
    @inbounds for i in eachindex(x)
        x[i] = 2 / x[i]
    end
end
@ctime foo!($x)
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo!(x)
    @inbounds @simd for i in eachindex(x)
        x[i] = 2 / x[i]
    end
end
@ctime foo!($x)
 
