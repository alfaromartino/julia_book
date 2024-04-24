####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used when writing this note.
# It requires having all files (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml) in the same folder.

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# We use `foo(ref($x))` for more accurate benchmarks of the function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
# necessary packages for this file
using BenchmarkTools, Random
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = sum(x)
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output = output + x[i]
    end

    return output
end
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    output = 0.
    
    for i in eachindex(x)
        output += x[i]
    end

    return output
end
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = sum(x)

function foo2(x)
    output = 0.

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = prod(x)

function foo2(x)
    output = 1.

    for i in eachindex(x)
        output *= x[i]
    end

    return output
end
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = maximum(x)

function foo2(x)
    output = -Inf

    for i in eachindex(x)
        output = max(output, x[i])
    end

    return output
end
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = minimum(x)

function foo2(x)
    output = Inf
    
    for i in eachindex(x)
        output = min(output, x[i])
    end

    return output
end
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = sum(2 .* x)

function foo2(x)
    output = 0.

    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end
 
@btime foo1(ref($x))
 
@btime foo2(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = prod(2 .* x)

function foo2(x)
    output = 1.

    for i in eachindex(x)
        output *= 2 * x[i]
    end

    return output
end
 
@btime foo1(ref($x))
 
@btime foo2(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = maximum(2 .* x)

function foo2(x)
    output = -Inf

    for i in eachindex(x)
        output = max(output, 2 * x[i])
    end

    return output
end
 
@btime foo1(ref($x))
 
@btime foo2(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo1(x) = minimum(2 .* x)

function foo2(x)
    output = Inf
    
    for i in eachindex(x)
        output = min(output, 2 * x[i])
    end

    return output
end
 
@btime foo1(ref($x))
 
@btime foo2(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x)                   = sum(2 .* x)
calling_foo_in_a_loop(x) = [foo(x) for _ in 1:100]

@btime calling_foo_in_a_loop(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    output = 0.
    for i in eachindex(x)
        output = output + 2 * x[i]
    end

    return output
end

calling_foo_in_a_loop(x) = [foo(x) for _ in 1:100]

@btime calling_foo_in_a_loop(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    output = 0.
    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end

calling_foo_in_a_loop(x) = [foo(x) for _ in 1:100]

@btime calling_foo_in_a_loop(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = sum(a -> 2 * a, x)

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = prod(a -> 2 * a, x)

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = maximum(a -> 2 * a, x)

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = minimum(a -> 2 * a, x)

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = all(a -> a > 0.5, x)

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = any(a -> a > 0.5, x)

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = sum(a -> a[1] * a[2], zip(x,y))

@btime foo(ref($x), ref($y))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = prod(a -> a[1] * a[2], zip(x,y))

@btime foo(ref($x), ref($y))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = maximum(a -> a[1] * a[2], zip(x,y))

@btime foo(ref($x), ref($y))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100); y = rand(100)

foo(x,y) = minimum(a -> a[1] * a[2], zip(x,y))

@btime foo(ref($x), ref($y))
 
