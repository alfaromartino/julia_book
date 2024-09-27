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
# for more accurate results, we perform benchmarks through functions and interpolate each variable.
# this means that benchmarking a function `foo(x)` should be `foo($x)`
using BenchmarkTools
 
# necessary packages for this file
using Random
 
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
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = sum(3 .* x)

function foo2(x)
    output = 0.

    for i in eachindex(x)
        output += 3 * x[i]
    end

    return output
end
 
@btime foo1($x)
 
@btime foo2($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = prod(3 .* x)

function foo2(x)
    output = 1.

    for i in eachindex(x)
        output *= 3 * x[i]
    end

    return output
end
 
@btime foo1($x)
 
@btime foo2($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = maximum(3 .* x)

function foo2(x)
    output = -Inf

    for i in eachindex(x)
        output = max(output, 3 * x[i])
    end

    return output
end
 
@btime foo1($x)
 
@btime foo2($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = minimum(3 .* x)

function foo2(x)
    output = Inf
    
    for i in eachindex(x)
        output = min(output, 3 * x[i])
    end

    return output
end
 
@btime foo1($x)
 
@btime foo2($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x)                   = sum(3 .* x)
calling_foo_in_a_loop(x) = [foo(x) for _ in 1:100]

@btime calling_foo_in_a_loop($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    output = 0.
    for i in eachindex(x)
        output = output + 3 * x[i]
    end

    return output
end

calling_foo_in_a_loop(x) = [foo(x) for _ in 1:100]

@btime calling_foo_in_a_loop($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    output = 0.
    for i in eachindex(x)
        output += 3 * x[i]
    end

    return output
end

calling_foo_in_a_loop(x) = [foo(x) for _ in 1:100]

@btime calling_foo_in_a_loop($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = sum(a -> 3 * a, x)

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = prod(a -> 3 * a, x)

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = maximum(a -> 3 * a, x)

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = minimum(a -> 3 * a, x)

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = all(a -> a > 0.5, x)

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = any(a -> a > 0.5, x)

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = sum(a -> a[1] * a[2], zip(x,y))

@btime foo($x, $y)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = prod(a -> a[1] * a[2], zip(x,y))

@btime foo($x, $y)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = maximum(a -> a[1] * a[2], zip(x,y))

@btime foo($x, $y)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = minimum(a -> a[1] * a[2], zip(x,y))

@btime foo($x, $y)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = reduce(+, x)

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = reduce(*, x)

@btime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = reduce(max, x)

@btime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = reduce(min, x)

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = mapreduce(a -> 3 * a, +, x)

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = reduce(+, map(a -> 3 * a, x))

@btime foo($x)
 
