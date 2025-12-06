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
 
# necessary packages for this file
using Random
 
############################################################################
#
#                           REDUCTIONS VIA FOR-LOOPS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo(x) = sum(x)
 
print_compact(foo(x))
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output = output + x[i]
    end

    return output
end
 
print_compact(foo(x))
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(x)
    output = 0.
    
    for i in eachindex(x)
        output += x[i]
    end

    return output
end
 
print_compact(foo(x))
 



############################################################################
#
#                           OPERATIONS APT FOR REDUCTIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo1(x) = sum(x)

function foo2(x)
    output = 0.

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
 
print_compact(foo1(x))
 
print_compact(foo2(x))
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo1(x) = prod(x)

function foo2(x)
    output = 1.

    for i in eachindex(x)
        output *= x[i]
    end

    return output
end
 
print_compact(foo1(x))
 
print_compact(foo2(x))
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo1(x) = maximum(x)

function foo2(x)
    output = -Inf

    for i in eachindex(x)
        output = max(output, x[i])
    end

    return output
end
 
print_compact(foo1(x))
 
print_compact(foo2(x))
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo1(x) = minimum(x)

function foo2(x)
    output = Inf
    
    for i in eachindex(x)
        output = min(output, x[i])
    end

    return output
end
 
print_compact(foo1(x))
 
print_compact(foo2(x))
 



############################################################################
#
#                           REDUCTIONS TO AVOID ALLOCATIONS OF INTERMEDIATE RESULTS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo1(x) = sum(log.(x))

function foo2(x)
    output = 0.

    for i in eachindex(x)
        output += log(x[i])
    end

    return output
end
 
@ctime foo1($x)
 
@ctime foo2($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo1(x) = prod(log.(x))

function foo2(x)
    output = 1.

    for i in eachindex(x)
        output *= log(x[i])
    end

    return output
end
 
@ctime foo1($x)
 
@ctime foo2($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo1(x) = maximum(log.(x))

function foo2(x)
    output = -Inf

    for i in eachindex(x)
        output = max(output, log(x[i]))
    end

    return output
end
 
@ctime foo1($x)
 
@ctime foo2($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo1(x) = minimum(log.(x))

function foo2(x)
    output = Inf
    
    for i in eachindex(x)
        output = min(output, log(x[i]))
    end

    return output
end
 
@ctime foo1($x)
 
@ctime foo2($x)
 



############################################################################
#
#                           REDUCTIONS VIA BUILT-IN FUNCTIONS
#
############################################################################
 
####################################################
#	SINGLE ARGUMENT
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = sum(log, x)        #same output as sum(log.(x))
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = prod(log, x)       #same output as prod(log.(x))
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = maximum(log, x)    #same output as maximum(log.(x))
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = minimum(log, x)    #same output as minimum(log.(x))
@ctime foo($x)
 



####################################################
#	SINGLE ARGUMENT and ANONYMOUS FUNCTION
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = sum(a -> 2 * a, x)       #same output as sum(2 .* x)
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = prod(a -> 2 * a, x)      #same output as prod(2 .* x)
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = maximum(a -> 2 * a, x)   #same output as maximum(2 .* x)
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = minimum(a -> 2 * a, x)   #same output as minimum(2 .* x)
@ctime foo($x)
 



####################################################
#	MULTIPLE ARGUMENTS
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = sum(a -> a[1] * a[2], zip(x,y))         #same output as sum(x .* y)
@ctime foo($x, $y)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = prod(a -> a[1] * a[2], zip(x,y))        #same output as prod(x .* y)
@ctime foo($x, $y)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = maximum(a -> a[1] * a[2], zip(x,y))     #same output as maximum(x .* y)
@ctime foo($x, $y)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = minimum(a -> a[1] * a[2], zip(x,y))     #same output as minimum(x .* y)
@ctime foo($x, $y)
 



############################################################################
#
#                           REDUCTIONS VIA FUNCTIONS
#
############################################################################
 
####################################################
#	REDUCE
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = reduce(+, x)           #same output as sum(x)
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = reduce(*, x)           #same output as prod(x)
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = reduce(max, x)         #same output as maximum(x)
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = reduce(min, x)         #same output as minimum(x)
@ctime foo($x)
 



####################################################
#	MAP REDUCE WITH A SINGLE ARGUMENT
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = mapreduce(log, +, x)       #same output as sum(log.(x))
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = mapreduce(log, *, x)       #same output as prod(log.(x))
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = mapreduce(log, max, x)     #same output as maximum(log.(x))
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100)

foo(x) = mapreduce(log, min, x)     #same output as minimum(log.(x))
@ctime foo($x)
 



####################################################
#	MAP REDUCE WITH MULTIPLE ARGUMENTS
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], +, zip(x,y))       #same output as sum(x .* y)
@ctime foo($x,$y)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], *, zip(x,y))       #same output as prod(x .* y)
@ctime foo($x,$y)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], max, zip(x,y))     #same output as maximum(x .* y)
@ctime foo($x,$y)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], min, zip(x,y))     #same output as minimum(x .* y)
@ctime foo($x,$y)
 



####################################################
#	REDUCE OR MAPREDUCE
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo(x) = mapreduce(a -> 2 * a, +, x)
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

foo(x) = reduce(+, map(a -> 2 * a, x))
@ctime foo($x)
 
