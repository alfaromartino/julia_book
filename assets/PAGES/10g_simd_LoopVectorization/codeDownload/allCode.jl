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
#			INDEPENDENCE OF ITERATIONS
#
############################################################################
 
####################################################
#	wrong result - this dependence is not allowed
####################################################
 
x = [0.1, 0.2, 0.3]

function foo!(x)
    for i in 2:length(x)
        x[i] = x[i-1] + x[i]
    end
end
foo!(x)
x
 
x = [0.1, 0.2, 0.3]

function foo!(x)
    @inbounds @simd for i in 2:length(x)
        x[i] = x[i-1] + x[i]
    end
end
foo!(x)
x
 
x = [0.1, 0.2, 0.3]

function foo!(x)
    @turbo for i in 2:length(x)
        x[i] = x[i-1] + x[i]
    end
end
foo!(x)
x
 
####################################################
#	you should apply it with independent iterations
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

foo(x)         = @turbo calculation.(x)
    
@ctime foo($x)
 
############################################################################
#
#			REDUCTIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = 0.0
    
    for i in eachindex(x)
        output += calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = 0.0
    
    @inbounds @simd for i in eachindex(x)
        output += calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = 0.0
    
    @turbo for i in eachindex(x)
        output += calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
############################################################################
#
#			SPECIAL FUNCTIONS
#
############################################################################
 
####################################################
#	LOGARITHMIC
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = log(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = log(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = log(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = log(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x)
 
####################################################
#	EXPONENTIAL
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = exp(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = exp(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = exp(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = exp(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x)
 
####################################################
#	POWER FUNCTIONS
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a^4

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a^4

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a^4

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a^4

foo(x) = @turbo calculation.(x)    
@ctime foo($x)
 



Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sqrt(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sqrt(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sqrt(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sqrt(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x)
 
####################################################
#	TRIGONOMETRIC FUNCTIONS
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sin(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sin(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sin(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sin(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x)
 
