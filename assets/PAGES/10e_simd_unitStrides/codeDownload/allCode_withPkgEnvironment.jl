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
 
using Random
 
############################################################################
#
#			PREVIEW CONCEPTS FOR EXAMPLES
#
############################################################################
 
x         = [10, 20, 30]

indices   = sortperm(x)
elements  = x[indices]    # equivalent to `sort(x)`
 
print_asis(indices)
 
print_asis(elements)
 



x         = [20, 10, 30]

indices   = x .> 15
elements  = x[indices]
 
print_asis(indices)
 
print_asis(elements)
 
x         = [2, 3, 4, 5, 6]

indices_1 = 1:length(x)         # unit strides, equivalent to 1:1:length(x)
indices_2 = 1:2:length(x)       # strides two
 
print_asis(collect(indices_1))
 
print_asis(collect(indices_2))
 
############################################################################
#
#			CONTIGUOUS BLOCKS OF MEMORY
#
############################################################################
 
####################################################
#	@simd is faster when elements are contiguous in memory
####################################################
 
####################################################
#	example 1
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = sortperm(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = sortperm(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = sortperm(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = sortperm(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
####################################################
#	example 2
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = x .> 0.5
y       = @view x[indices]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = x .> 0.5
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
####################################################
#	choice between copy or views doesn't matter if access is contiguous
#       hence, views are faster as they avoid memory allocations
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(1_000_000)

indices = 1:length(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(1_000_000)

indices = 1:length(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(1_000_000)

indices = 1:length(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(1_000_000)

indices = 1:length(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
####################################################
#	a copy is faster when multiple operations with the same object are performed
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = @view x[indices]
    output1, output2, output3 = (0.0 for _ in 1:3)

    @simd for a in y
        output1 += a^(3/2)
        output2 += a / 3
        output3 += a * 2.5
    end

    return output1, output2, output3
end
@ctime foo($x, $indices)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = x[indices]
    output1, output2, output3 = (0.0 for _ in 1:3)

    @simd for a in y
        output1 += a^(3/2)
        output2 += a / 3
        output3 += a * 2.5
    end

    return output1, output2, output3
end
@ctime foo($x, $indices)
 
# ultimately a race horse between not copying data vs SIMD efficiency
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = @view x[indices]
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices)
 
####################################################
#	example 2
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(10_000)
indices = x .> 0.5
y       = @view x[indices]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(10_000)
indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(10_000)
indices = x .> 0.5
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(10_000)
indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 
# ultimately a race horse between not copying data vs SIMD efficiency
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(10_000)
indices = x .> 0.5

function foo(x,indices)
    y      = @view x[indices]
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(10_000)
indices = x .> 0.5

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(10_000)
indices = x .> 0.5

function foo(x,indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices)
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(10_000)
indices = x .> 0.5

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices)
 
####################################################
#	ultimately a race horse between not copying data vs SIMD efficiency
####################################################
 
# view faster here
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)
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
x       = rand(5_000_000)
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
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
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

    @simd for a in y
        output += a^(3/2)
    end

    return output
end
@ctime foo($x, $indices)
 
############################################################################
#
#			UNIT STRIDES
#
############################################################################
 
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
 
############################################################################
#
#			another example of unit strides
#
############################################################################
 
# vectors we'll use
 
Random.seed!(123)       #setting seed for reproducibility
x_size = 1_000_000

x = rand(x_size)

y = zeros(eltype(x),x_size * 2)
    temp  = view(y, 2:2:length(y))
    temp .= x
 
print_asis(x[1:3])
 
print_asis(y[1:6],12)
 
# simd is faster with unit strides
 
function foo(x)
    output = 0.0

    @inbounds @simd for i in 1:length(x)
        output += x[i]
    end

    return output
end
@ctime foo($x)
 
function foo(y)
    output = 0.0

    @inbounds @simd for i in 2:2:length(y)
        output += y[i]
    end

    return output
end
@ctime foo($y)
 
####################################################
#	copies vs views - simd is faster with unit strides
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
 
