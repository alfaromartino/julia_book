# to execute the benchmarks
using BenchmarkTools
ref(x) = (Ref(x))[]

# To print results with a specific format (only relevant for the website)
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x) 
 
 x = [1, 2, 3]

function foo(x)
    a = x[1:2]          # it allocates ONE vector -> the slice 'x[1:2]'
    sum(a)
end

@btime foo(ref($x)) 
 
 x = [1, 2, 3]

function foo(x)    
    sum(x[1:2])         # it allocates ONE vector -> the slice 'x[1:2]'
end

@btime foo(ref($x)) 
 
 x = [1, 2, 3]

function foo(x)
    a = view(x, 1:2)    # it doesn't allocate
    sum(a)
end

@btime foo(ref($x)) 
 
 x = [1, 2, 3]

function foo(x)
    a = x[1:2]
    b = x[2:3]

    sum(a) * sum(b)
end

replicate(x) = [foo(x) for _ in 1:100]

@btime replicate(ref($x)) 
 
 x = [1, 2, 3]

@views function foo(x)
    a = x[1:2]
    b = x[2:3]

    sum(a) * sum(b)
end

replicate(x) = [foo(x) for _ in 1:100]

@btime replicate(ref($x)) 
 
 x       = collect(1:100)
indices = isodd.(1:length(x))

function foo(x, indices)
    sum(x[indices])
end

@btime foo(ref($x), ref($indices)); 
 
 x       = collect(1:100)
indices = isodd.(1:length(x))

@views function foo(x, indices)
    sum(x[indices])
end

@btime foo(ref($x), ref($indices)); 
 
 x       = collect(1:100)


function foo(x)
    sum(x[1:2:end])
end

@btime foo(ref($x)); 
 
 x       = collect(1:100)


@views function foo(x)
    sum(x[1:2:end])
end

@btime foo(ref($x)); 
 
 using Skipper
x = collect(1:100)

function foo(x)
    sum(skip(isodd, x))
end

@btime foo(ref($x)); 
 
 using Skipper
x = collect(1:100)

@views function foo(x)
    sum(skip(isodd, x))
end

@btime foo(ref($x)); 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
nr_obs  = 10_000
x       = rand(nr_obs)
indices = randperm(nr_obs)          # indices to be used for subsetting (randomly permuted)

foo(x, indices) = max.(x[indices].^2 , 0.25)

@btime foo(ref($x), ref($indices)); 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
nr_obs  = 10_000
x       = rand(nr_obs)
indices = randperm(nr_obs)          # indices to be used for subsetting (randomly permuted)

foo(x, indices) = max.(view(x,indices).^2 , 0.25)

@btime foo(ref($x), ref($indices)); 
 
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
 
 