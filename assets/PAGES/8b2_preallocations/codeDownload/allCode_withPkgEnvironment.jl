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
# We use `foo(ref($x))` for more accurate benchmarks of any function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
# necessary packages for this file
# using Random
 
x           = collect(1:100)
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        similar(x)
    end
end

@btime foo(ref($x), ref($repetitions))
 

x           = collect(1:100)
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        Vector{Int64}(undef, length(x))
    end
end

@btime foo(ref($x), ref($repetitions))
 

x           = collect(1:100)
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        zeros(Int64, length(x))
    end
end

@btime foo(ref($x), ref($repetitions))
 

x           = collect(1:100)
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        ones(Int64, length(x))
    end
end

@btime foo(ref($x), ref($repetitions))
 

x           = collect(1:100)
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        fill(2, length(x))                  # vector filled with integer 2
    end
end

@btime foo(ref($x), ref($repetitions))
 

x = [1,2,3]

function foo(x)
    a = similar(x); b = similar(x); c = similar(x)    
    # <some calculations using a,b,c>
end

@btime foo(ref($x))
 

x = [1,2,3]

function foo(x; a = similar(x), b = similar(x), c = similar(x))
    
    # <some calculations using a,b,c>
end

@btime foo(ref($x))
 

x = [1,2,3]

function foo(x)
    a,b,c = [similar(x) for _ in 1:3]
    # <some calculations using a,b,c>
end

@btime foo(ref($x))
 

x = [1,2,3]

function foo(x)
    a,b,c = (similar(x) for _ in 1:3)
    # <some calculations using a,b,c>
end

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = sum(2 .* x)                  # 2 .* x implicitly creates a temporary vector  

@btime foo(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    output = similar(x)               # you need to create this vector to store the results

    for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end

@btime foo(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = 2 .* x

calling_foo_in_a_loop(x) = [sum(foo(x)) for _ in 1:100]

@btime calling_foo_in_a_loop(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x; output = similar(x))
    for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end

calling_foo_in_a_loop(output,x) = [sum(foo(x)) for _ in 1:100]

@btime calling_foo_in_a_loop(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)
output = similar(x)

function foo!(output,x)
    for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end

@btime foo!(ref($output), ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)
output = similar(x)

function foo!(output,x)
    for i in eachindex(x)
        output[i] = 2 * x[i]
    end

    return output
end

calling_foo_in_a_loop(output,x) = [sum(foo!(output,x)) for _ in 1:100]

@btime calling_foo_in_a_loop(ref($output),ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)
output = similar(x)

foo!(output,x) = (output .= 2 .* x)

@btime foo!(ref($output), ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)
output = similar(x)

foo!(output,x) = (@. output = 2 * x)

@btime foo!(ref($output), ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)
output = similar(x)

foo!(output,x) = (@. output = 2 * x)

calling_foo_in_a_loop(output,x) = [sum(foo!(output,x)) for _ in 1:100]

@btime calling_foo_in_a_loop(ref($output),ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

foo(x) = [sum(x .> x[i]) for i in eachindex(x)]

@btime foo(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x) 
    temp   = [x .> x[i] for i in eachindex(x)]
    output = sum.(temp)
end

@btime foo(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x; output = similar(x))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@btime foo(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo!(x; output = similar(x), temp = similar(x))
    for i in eachindex(x)        
        for j in eachindex(x)
            temp[j] = x[j] > x[i]
        end
        output[i] = sum(temp)
    end

    return output
end

@btime foo!(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo!(x; output = similar(x), temp = similar(x))
    for i in eachindex(x)
        temp     .= x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@btime foo!(ref($x));
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo!(x; output = similar(x), temp = similar(x))
    for i in eachindex(x)
        @. temp      = x > x[i]
           output[i] = sum(temp)
    end

    return output
end

@btime foo!(ref($x));
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function update_temp!(x, temp, i)
    for j in eachindex(x)        
       temp[j] = x[j] > x[i]
    end    
end

function foo!(x; output = similar(x), temp = similar(x))
    for i in eachindex(x)
        update_temp!(x, temp, i)
        output[i] = sum(temp)
    end

    return output
end

@btime foo!(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

update_temp!(x, temp, i) = (@. temp = x > x[i])

function foo!(x; output = similar(x), temp = similar(x))
    for i in eachindex(x)
           update_temp!(x, temp, i)
           output[i] = sum(temp)
    end

    return output
end

@btime foo!(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)



update_temp!(x, temp, i) = (@. temp = x > x[i])

function foo!(x; output = similar(x), temp = similar(x))
    for i in eachindex(x)
           update_temp!(x, temp, i)
           output[i] = sum(temp)
    end
    return output
end

calling_foo_in_a_loop(x) = [foo!(x) for _ in 1:1_000]

@btime calling_foo_in_a_loop(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x      = rand(100)
output = similar(x)
temp   = similar(x)

update_temp!(x, temp, i) = (@. temp = x > x[i])

function foo!(x, output, temp)    
    for i in eachindex(x)
           update_temp!(x, temp, i)
           output[i] = sum(temp)
    end
    return output
end

calling_foo_in_a_loop(x, output, temp) = [foo!(x, output, temp) for _ in 1:1_000]

@btime calling_foo_in_a_loop(ref($x), ref($output), ref($temp))
 
