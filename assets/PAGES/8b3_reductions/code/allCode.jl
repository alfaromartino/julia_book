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
 
 