####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate results, we benchmark code through functions.
    # We also interpolate each function argument, so that they're taken as local variables.
    # All this means that benchmarking a function `foo(x)` is done via `foo($x)`
using BenchmarkTools

# The following defines the macro `@ctime`, which is equivalent to `@btime` but faster
    # to use it, replace `@btime` with `@ctime`
using Chairmarks
macro ctime(expr)
    esc(quote
        object = @b $expr
        result = sprint(show, "text/plain", object) |>
            x -> object.allocs == 0 ?
                x * " (0 allocations: 0 bytes)" :
                replace(x, "allocs" => "allocations") |>
            x -> replace(x, r",.*$" => ")") |>
            x -> replace(x, "(without a warmup) " => "")
        println("  " * result)
    end)
end

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
using Random, LazyArrays, LoopVectorization, StatsBase, Distributions
 
############################################################################
#
#			SIMD (SINGLE INSTRUCTION, MULTIPLE DATA)
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo!(x)
    for i in eachindex(x)
        x[i] = 2 * x[i]
    end
end
@ctime foo!($x)
 
Random.seed!(123)       #setting the seed for reproducibility
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
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(1_000_000)

foo(x) = 2 ./ x
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @simd for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo!(x)
    for i in eachindex(x)
        x[i] = 2 / x[i]
    end
end
@ctime foo!($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo!(x)
    @inbounds for i in eachindex(x)
        x[i] = 2 / x[i]
    end
end
@ctime foo!($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo!(x)
    @inbounds @simd for i in eachindex(x)
        x[i] = 2 / x[i]
    end
end
@ctime foo!($x)
 
