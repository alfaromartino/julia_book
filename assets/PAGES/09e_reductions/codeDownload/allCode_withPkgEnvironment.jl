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
 
# necessary packages for this file
using Random
 
############################################################################
#
#                           REDUCTIONS VIA FOR-LOOPS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = sum(x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output = output + x[i]
    end

    return output
end
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    output = 0.
    
    for i in eachindex(x)
        output += x[i]
    end

    return output
end
 


############################################################################
#
#                           OPERATIONS APT FOR REDUCTIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = sum(x)

function foo2(x)
    output = 0.

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = prod(x)

function foo2(x)
    output = 1.

    for i in eachindex(x)
        output *= x[i]
    end

    return output
end
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = maximum(x)

function foo2(x)
    output = -Inf

    for i in eachindex(x)
        output = max(output, x[i])
    end

    return output
end
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = minimum(x)

function foo2(x)
    output = Inf
    
    for i in eachindex(x)
        output = min(output, x[i])
    end

    return output
end
 


############################################################################
#
#                           REDUCTIONS TO AVOID ALLOCATIONS OF INTERMEDIATE RESULTS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = sum(log.(x))

function foo2(x)
    output = 0.

    for i in eachindex(x)
        output += log(x[i])
    end

    return output
end
 
@btime foo1($x)
 
@btime foo2($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = prod(log.(x))

function foo2(x)
    output = 1.

    for i in eachindex(x)
        output *= log(x[i])
    end

    return output
end
 
@btime foo1($x)
 
@btime foo2($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = maximum(log.(x))

function foo2(x)
    output = -Inf

    for i in eachindex(x)
        output = max(output, log(x[i]))
    end

    return output
end
 
@btime foo1($x)
 
@btime foo2($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = minimum(log.(x))

function foo2(x)
    output = Inf
    
    for i in eachindex(x)
        output = min(output, log(x[i]))
    end

    return output
end
 
@btime foo1($x)
 
@btime foo2($x)
 


############################################################################
#
#                           REDUCTIONS VIA BUILT-IN FUNCTIONS
#
############################################################################
 
####################################################
#	SINGLE ARGUMENT
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = sum(log, x)        #same output as sum(log.(x))
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = prod(log, x)       #same output as prod(log.(x))
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = maximum(log, x)    #same output as maximum(log.(x))
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = minimum(log, x)    #same output as minimum(log.(x))
@btime foo($x)
 


####################################################
#	SINGLE ARGUMENT and ANONYMOUS FUNCTION
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = sum(a -> 2 * a, x)       #same output as sum(2 .* x)
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = prod(a -> 2 * a, x)      #same output as prod(2 .* x)
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = maximum(a -> 2 * a, x)   #same output as maximum(2 .* x)
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = minimum(a -> 2 * a, x)   #same output as minimum(2 .* x)
@btime foo($x)
 


####################################################
#	MULTIPLE ARGUMENTS
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = sum(a -> a[1] * a[2], zip(x,y))         #same output as sum(x .* y)
@btime foo($x, $y)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = prod(a -> a[1] * a[2], zip(x,y))        #same output as prod(x .* y)
@btime foo($x, $y)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = maximum(a -> a[1] * a[2], zip(x,y))     #same output as maximum(x .* y)
@btime foo($x, $y)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = minimum(a -> a[1] * a[2], zip(x,y))     #same output as minimum(x .* y)
@btime foo($x, $y)
 


############################################################################
#
#                           REDUCTIONS VIA FUNCTIONS
#
############################################################################
 
####################################################
#	REDUCE
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = reduce(+, x)           #same output as sum(x)
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = reduce(*, x)           #same output as prod(x)
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = reduce(max, x)         #same output as maximum(x)
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = reduce(min, x)         #same output as minimum(x)
@btime foo($x)
 


####################################################
#	MAP REDUCE WITH A SINGLE ARGUMENT
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = mapreduce(log, +, x)       #same output as sum(log.(x))
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = mapreduce(log, *, x)       #same output as prod(log.(x))
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = mapreduce(log, max, x)     #same output as maximum(log.(x))
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)

foo(x) = mapreduce(log, min, x)     #same output as minimum(log.(x))
@btime foo($x)
 


####################################################
#	MAP REDUCE WITH MULTIPLE ARGUMENTS
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], +, zip(x,y))       #same output as sum(x .* y)
@btime foo($x,$y)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], *, zip(x,y))       #same output as prod(x .* y)
@btime foo($x,$y)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], max, zip(x,y))     #same output as maximum(x .* y)
@btime foo($x,$y)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], min, zip(x,y))     #same output as minimum(x .* y)
@btime foo($x,$y)
 


####################################################
#	REDUCE OR MAPREDUCE
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = mapreduce(a -> 2 * a, +, x)
@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = reduce(+, map(a -> 2 * a, x))
@btime foo($x)
 
