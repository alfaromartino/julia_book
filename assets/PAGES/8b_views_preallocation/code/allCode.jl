# to execute the benchmarks
using BenchmarkTools
ref(x) = (Ref(x))[]

# To print results with a specific format (only relevant for the website)
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x) 
 
 x = [1, 2, 3]

foo(x)= sum(x[1:2])           # it allocates ONE vector -> the slice 'x[1:2]'

@btime foo(ref($x)) 
 
 x = [1, 2, 3]

foo(x) = sum(@view(x[1:2]))    # it doesn't allocate

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = @views sum(x[x .> 0.5])

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo(ref($x)) 
 
 using Skipper
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(skip(≤(0.5), x))

@btime foo(ref($x)); 
 
 #
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(Iterators.filter(>(0.5), x))

@btime foo(ref($x)); 
 
 #
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(a for a in x if a > 0.5)

@btime foo(ref($x)); 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100_000)

foo(x) = max.(x[1:2:length(x)], 0.5)

@btime foo(ref($x)); 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100_000)

foo(x) = max.(@view(x[1:2:length(x)]), 0.5)

@btime foo(ref($x)); 
 
 x           = [1,2,3]
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        similar(x)
    end
end

@btime foo(ref($x), ref($repetitions)) 
 
 x           = [1,2,3]
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        Vector{Int64}(undef, length(x))
    end
end

@btime foo(ref($x), ref($repetitions)) 
 
 x           = [1,2,3]
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        zeros(Int64, length(x))
    end
end

@btime foo(ref($x), ref($repetitions)) 
 
 x           = [1,2,3]
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        ones(Int64, length(x))
    end
end

@btime foo(ref($x), ref($repetitions)) 
 
 x           = [1,2,3]
repetitions = 100_000                       # repetitions in a for-loop

function foo(x, repetitions)
    for _ in 1:repetitions
        fill(2, length(x))                  # vector filled with integer 2
    end
end

@btime foo(ref($x), ref($repetitions)) 
 
 x = [1,2,3]

function foo(x)
    a = similar(x) ; b = similar(x); c = similar(x)    

    # here we'd have calculations using a,b,c
end

@btime foo(ref($x)) 
 
 x = [1,2,3]

function foo(x; a = similar(x), b = similar(x), c = similar(x))
    

    # here we'd have calculations using a,b,c
end

@btime foo(ref($x)) 
 
 x = [1,2,3]

function foo(x)
    a,b,c = [similar(x) for _ in 1:3]

    # here we'd have calculations using a,b,c
end

@btime foo(ref($x)) 
 
 x = [1,2,3]

function foo(x)
    a,b,c = (similar(x) for _ in 1:3)

    # here we'd have calculations using a,b,c
end

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

baseline(x) = [sum(x .> x[i]) for i in eachindex(x)]

@btime baseline(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function baseline(x)
    output = similar(x)

    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@btime baseline(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function prealloc_temp(x)
    output = similar(x) ; temp = similar(x)

    for i in eachindex(x)
        temp     .= x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@btime prealloc_temp(ref($x)); 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function prealloc_temp(x)
    output, temp = (similar(x) for _ in 1:2)

    for i in eachindex(x)
        temp     .= x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@btime prealloc_temp(ref($x)); 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function prealloc_temp(x; output=similar(x), temp=similar(x))
    for i in eachindex(x)
        @. temp      = x > x[i]
           output[i] = sum(temp)
    end

    return output
end



@btime prealloc_temp(ref($x)); 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function update_temp!(x, temp, i)
    for j in eachindex(x)        
       temp[j] = x[j] > x[i]
    end    
end

function prealloc_temp(x; output=similar(x), temp=similar(x))
    for i in eachindex(x)
        update_temp!(x, temp, i)
        output[i] = sum(temp)
    end

    return output
end

@btime prealloc_temp(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

update_temp!(x, temp, i) = (@. temp = x > x[i])

function prealloc_temp(x; output=similar(x), temp=similar(x))
    for i in eachindex(x)
           update_temp!(x, temp, i)
           output[i] = sum(temp)
    end

    return output
end

@btime prealloc_temp(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

update_temp!(x, temp, i) = (@. temp = x > x[i])

function prealloc_temp(x; output=similar(x), temp=similar(x))
    for i in eachindex(x)
           update_temp!(x, temp, i)
           output[i] = sum(temp)
    end
    return output
end

replicate(x) = [prealloc_temp(x) for _ in 1:1_000]

@btime replicate(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100); output = similar(x); temp = similar(x)

update_temp!(x, temp, i) = (@. temp = x > x[i])

function prealloc_temp(x, output, temp)    
    for i in eachindex(x)
           update_temp!(x, temp, i)
           output[i] = sum(temp)
    end
    return output
end

replicate(x, output, temp) = [prealloc_temp(x, output, temp) for _ in 1:1_000]

@btime replicate(ref($x), ref($output), ref($temp)) 
 
 