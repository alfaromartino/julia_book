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
 
using Random
 
############################################################################
#
#			INDEPENDENCE OF ITERATIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = x[i] / 2 + x[i]^2 / 3
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = x[i] / 2 + x[i]^2 / 3
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)

foo(x) = @. x / 2 + x^2 / 3
    
@ctime foo($x)
 
############################################################################
#
#			REDUCTIONS
#
############################################################################
 
####################################################
#	automatic application of SIMD for Int in reductions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1:10, 10_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1:10, 10_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    @simd for a in x
        output += a
    end

    return output
end
@ctime foo($x)
 
####################################################
#	no automatic application of SIMD for Float in reductions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(10_000_000)

function foo(x)
    output = 0.0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(10_000_000)

function foo(x)
    output = 0.0

    @simd for a in x
        output += a
    end

    return output
end
@ctime foo($x)
 
############################################################################
#
#			CONTIGUOUS BLOCKS OF MEMORY
#
############################################################################
 
x               = [20, 10, 30]

sorted_indices  = sortperm(x)
sorted_elements = x[sorted_indices]    # equivalent to `sort(x)`
 
####################################################
#	@simd is faster when elements are contiguous in memory
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)
y = @view x[sortperm(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)
y = @view x[sortperm(x)]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)
y = x[sortperm(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)
y = x[sortperm(x)]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



####################################################
#	ultimately a race horse between not copying data vs SIMD efficiency
####################################################
 
# view faster here
 
Random.seed!(123)       #setting the seed for reproducibility
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices)
 
Random.seed!(123)       #setting the seed for reproducibility
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices)
 
# copy is faster below
 
Random.seed!(123)       #setting the seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = @view x[indices]
    output = 0.0

    for a in y
        output += a^(3/2)
    end

    return output
end
@ctime foo($x, $indices)
 
Random.seed!(123)       #setting the seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = x[indices]
    output = 0.0

    for a in y
        output += a^(3/2)
    end

    return output
end
@ctime foo($x, $indices)
 
# typical example where copy may be faster is polynomies (simd applied automatically without @simd here)
 
Random.seed!(123)       #setting the seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    for a in y
        output += a * 0.1 + a^2 * 0.2 - a^3 * 0.3 +  a^4 * 0.4
    end

    return output
end
@ctime foo($x,$indices)
 
Random.seed!(123)       #setting the seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a * 0.1 + a^2 * 0.2 - a^3 * 0.3 +  a^4 * 0.4
    end

    return output
end
@ctime foo($x,$indices)
 
Random.seed!(123)       #setting the seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = @views x[indices]
    output = 0.0

    for a in y
        output += a * 0.1 + a^2 * 0.2 - a^3 * 0.3 +  a^4 * 0.4
    end

    return output
end
@ctime foo($x,$indices)
 
Random.seed!(123)       #setting the seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = @views x[indices]
    output = 0.0

    @simd for a in y
        output += a * 0.1 + a^2 * 0.2 - a^3 * 0.3 +  a^4 * 0.4
    end

    return output
end
@ctime foo($x,$indices)
 
####################################################
#	simd is faster with unit strides
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)
y = @view x[1:2:length(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)
y = @view x[1:2:length(x)]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)
y = x[1:2:length(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000_000)
y = x[1:2:length(x)]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



# overall effect
 
Random.seed!(123)       #setting the seed for reproducibility
x       = rand(1_000_000)
indices = 1:2:length(x)

function foo(x, indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices)
 
Random.seed!(123)       #setting the seed for reproducibility
x       = rand(1_000_000)
indices = 1:2:length(x)

function foo(x, indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices)
 
