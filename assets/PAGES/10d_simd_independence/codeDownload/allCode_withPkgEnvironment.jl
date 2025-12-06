####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


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
 
using Random
 
############################################################################
#
#			INDEPENDENCE OF ITERATIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = x[i] / 2 + x[i]^2 / 3
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = x[i] / 2 + x[i]^2 / 3
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
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
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1:10, 10_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
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
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(10_000_000)

function foo(x)
    output = 0.0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
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
 
print_asis(sorted_indices)
 
print_asis(sorted_elements)
 



####################################################
#	@simd is faster when elements are contiguous in memory
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 
Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 



# example where copy is faster
 
Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 
Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 
Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 
Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 
