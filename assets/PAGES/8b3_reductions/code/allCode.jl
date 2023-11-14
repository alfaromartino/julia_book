# to execute the benchmarks
using BenchmarkTools
ref(x) = (Ref(x))[]

# To print results with a specific format (only relevant for the website)
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = sum(2 .* x)

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    output = 0.
    for i in eachindex(x)
        output = output + 2 * x[i]
    end

    return output
end

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    output = 0.
    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x)                   = sum(2 .* x)
calling_foo_in_a_loop(x) = [foo(x) for _ in 1:100]

@btime calling_foo_in_a_loop(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
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
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
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
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = maximum(2 .* x)

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    output = 0.
    for i in eachindex(x)
        output = max(output, 2*x[i])
    end

    return output
end

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = sum(a -> 2 * a, x)

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = maximum(a -> 2 * a, x)

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = prod(a -> 2 * a, x)

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100); y = rand(100)

foo(x,y) = sum(a -> (a[1] * a[2]), zip(x,y))

@btime foo(ref($x), ref($y)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100); y = rand(100)

foo(x,y) = maximum(a -> (a[1] * a[2]), zip(x,y))

@btime foo(ref($x), ref($y)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100); y = rand(100)

foo(x,y) = prod(a -> (a[1] * a[2]), zip(x,y))

@btime foo(ref($x), ref($y)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

our_mean(x) = mapreduce(a -> a/length(x), +, x)
@btime our_mean(ref($x))

our_mean(x) = mapreduce(identity, +, x) / length(x)
@btime our_mean(ref($x))

import Statistics: mean
@btime mean(ref($x))

our_weighted_mean(x,y) = mapreduce(x-> x[1]*x[2], +, zip(x,y))
@btime our_weighted_mean(ref($x), ref($y))

our_weighted_mean(x,y) = reduce(+, map(x-> x[1]*x[2], zip(x,y)))
@btime our_weighted_mean(ref($x), ref($y))

our_weighted_mean(x,y) = reduce(+, map((a,b)-> a*b, x,y))
@btime our_weighted_mean(ref($x), ref($y))

our_weighted_mean(x,y) = mapreduce(splat(*), +, zip(x,y))
@btime our_weighted_mean(ref($x), ref($y))

@btime mean(ref($x), weights(ref($y))) 
 
 