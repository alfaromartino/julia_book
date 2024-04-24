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
using LazyArrays
 
####################################################
#	GENERATORS VS ARRAY COMPREHENSIONS
####################################################
 
x = [a for a in 1:10]
 
x = (a for a in 1:10)
 
x = 1:10
 
x = collect(1:10)
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    y = [a * 2 for a in x]                  # 1 allocation (same as y = x .* 2)
    
    sum(y)
end
    
@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    y = (a * 2 for a in x)                  # 0 allocations
    
    sum(y)
end
    
@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = sum(a * 2 for a in x)              # 0 allocations
    
@btime foo(ref($x))
 
############################################################################
#
#                           ITERATORS
#
############################################################################



####################################################
#	FILTER
####################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = collect(1:100)

function foo(x)
    sum(x .> 50)                            # 1 allocation
end
    
@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = collect(1:100)

function foo(x)
    y = filter(a -> a > 50, x)              # 1 allocation 

    sum(y)
end
    
@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = collect(1:100)

function foo(x)
    y = Iterators.filter(a -> a > 50, x)    # 0 allocations 

    sum(y)
end
    
@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = collect(1:100)

function foo(x)
    y = (a for a in x if a > 50)            # 0 allocations

    sum(y)
end
    
@btime foo(ref($x))
 
####################################################
#	MAP
####################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x) 
    y = map(a -> a * 2, x)                  # 1 allocation

    sum(y)
end
    
@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    y = Iterators.map(a -> a * 2, x)        # 0 allocations

    sum(y)
end
    
@btime foo(ref($x))
 
############################################################################
#
#                           LAZY BROADCASTING
#
############################################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
# broadcasting eager by default
x = rand(100) ; y = rand(100)

foo(x,y) = sum(2 .* x) + sum(2 .* y) / sum(x .* y)

@btime foo($x,$y)
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
using LazyArrays
x = rand(100) ; y = rand(100)

foo(x,y) = sum(@~ 2 .* x) + sum(@~ 2 .* y) / sum(@~ x .* y)

@btime foo($x,$y)
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx        = @. 4 * x^3 + 3 * x^2 + 2 * x + 1
    ly        = @. 2 * y^3 + 3 * y^2 + 4 * y + 1
    
    
    sum(lx ./ ly)
end

@btime foo(ref($x),ref($y))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 4 * a^3 + 3 * a^2 + 2 * a + 1
    ly(b)     = 2 * b^3 + 3 * b^2 + 4 * b + 1
    temp(a,b) = lx(a) / ly(b)
    
    sum(Iterators.map(temp, x,y))
end

@btime foo(ref($x),ref($y))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 4 * a^3 + 3 * a^2 + 2 * a + 1
    ly(b)     = 2 * b^3 + 3 * b^2 + 4 * b + 1
    temp(a,b) = lx(a) / ly(b)
    
    sum(@~ temp.(x,y))
end

@btime foo(ref($x),ref($y))
 
####################################################
#	CONDITIONS
####################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    condition1     = x .> 0.25
    condition2     = x .< 0.75    


    sum(condition1 .&& condition2)
end

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    condition1     = (a > 0.25 for a in x)
    condition2     = (a < 0.75 for a in x)
    all_conditions = ((x && y) for (x,y) in  zip(condition1, condition2))
        
    sum(all_conditions)
end

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    condition(x) = 0.75 > x > 0.25
    


    sum(@~ condition.(x))
end


@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    condition1(a)     = a > 0.25
    condition2(a)     = a < 0.75
    all_conditions(a) = condition1(a) && condition2(a)
    
    sum(@~ all_conditions.(x))
end

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    all_conditions    = Iterators.map(a ->  0.25 < a < 0.75 , x)    
    

    sum(all_conditions)
end

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    condition1(a)     = a > 0.25
    condition2(a)     = a < 0.75    
    all_conditions    = Iterators.map(a -> condition1(a) && condition2(a) , x)    

    sum(all_conditions)
end

@btime foo(ref($x))
 
####################################################
#	CONDITIONS
####################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x       = rand(100)
weights = rand(100) |> (y ->  y ./ sum(y))

temp(x,weights)           = x * weights
weighted_share(x,weights) = sum(temp.(x,weights))

@btime weighted_share(ref($x), ref($weights))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x       = rand(100)
weights = rand(100) |> (y ->  y ./ sum(y))

temp(x,weights)           = x * weights
weighted_share(x,weights) = sum(Iterators.map(temp, x, weights))

@btime weighted_share(ref($x), ref($weights))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x       = rand(100)
weights = rand(100) |> (y ->  y ./ sum(y))

temp(x,weights)           = x * weights
weighted_share(x,weights) = sum(@~ temp.(x,weights))

@btime weighted_share(ref($x), ref($weights))
 
