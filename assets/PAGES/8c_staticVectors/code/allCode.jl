include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using BenchmarkTools, StaticArrays
 
# all 'sx' define a static vector with same elements as 'x'
x = collect(1:10)

sx = SVector(x...)
sx = SVector{length(x), eltype(x)}(x)
sx = SA[x...]
sx = @SVector [a for a in x]
 
print_asis(sx, 10)
 
# all 'sx' define the same static vector '[3,4,5]'


sx = SVector(3,4,5)
sx = SVector{3, Int64}(3,4,5)
sx = SA[3,4,5]
sx = @SVector [i for i in 3:5]
 
print_asis(sx)
 
x = collect(3:10) ; sx = SVector(x...)

# both define static vectors
slice1 = sx[:]
slice2 = sx[SA[1,2]]        # or slice2 = sx[SVector(1,2)]
 
print_asis(slice1)
 
print_asis(slice2)
 
x = collect(3:10) ; sx = SVector(x...)

# both define and ordinary vector
slice2 = sx[1:2]
slice2 = sx[[1,2]]
 
print_asis(slice2)
 
x = collect(3:10) ; sx = SVector(x...)

slice1 = sx[1]
slice2 = sx[:]
 
print_asis(slice2)
 
x = collect(3:10) ; sx = SVector(x...)

slice1 = sx[1]
slice2 = sx[:]
 
print_asis(slice2)
 
x  = [1,2,3]
sx = SVector(x...)

#sx[1] = 0          # ERROR: setindex!(::SVector{3, Int64}, value, ::Int) is not defined.
 
x  = [1,2,3]
mx = MVector(x...)

mx[1] = 0
 
print_asis(mx, 10)
 
sx = SVector(1,2,3)

mx = similar(sx)        # it defines an MVector with undef elements
 
print_asis(mx, 10)
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10)

function foo(x)
    a = x[1:2]              # 1 allocation (copy of slice)
    b = [3,4]               # 1 allocation (vector creation)

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10)

@views function foo(x)
    a = x[1:2]              # 0 allocation (view of slice)
    b = [3,4]               # 1 allocation (vector creation) 

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10);   tup = Tuple(x)

function foo(x)
    a = x[1:2]              # 0 allocation (slice of tuple)
    b = (3,4)               # 0 allocation (tuple creation)

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@btime foo(ref($tup)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10);   sx = SA[x...]

function foo(x)
    a = x[SA[1,2]]          # 0 allocation (slice of static array)
    b = SA[3,4]             # 0 allocation (static array creation)

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@btime foo(ref($sx)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10);   mx = MVector(x...)

function foo(x)
    a = x[MVector(1,2)]     # 0 allocation (slice of static array)
    b = MVector(3,4)        # 0 allocation (static array creation)

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@btime foo(ref($mx))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10)

foo(x) = sum(2 .* x)

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10);   sx = SVector(x...)

foo(x) = sum(2 .* x)

@btime foo(ref($sx)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x  = rand(10)

foo(x) = sum(a -> 10 + 2a +  3a^2, x)

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x  = rand(10);  sx = SVector(x...);

foo(x) = sum(a -> 10 + 2a +  3a^2, x)

@btime foo(ref($sx)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x  = rand(10)
sx = SVector(x...);  mx = MVector(x...)

foo(x) = sum(a -> 10 + 2a +  3a^2, x)
 
@btime foo(ref($x))
 
@btime foo(ref($sx))
 
@btime foo(ref($mx))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x  = rand(10)
sx = SVector(x...);  mx = MVector(x...)

foo(x) = 10 + 2x +  3x^2
 
@btime foo.(ref($x))
 
@btime foo.(ref($sx))
 
@btime foo.(ref($mx))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(50)

function foo(x; output = similar(x))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end
 
@btime foo(ref($x))
 
using Random, StaticArrays; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(50)

function foo(x; output = similar(x), temp = similar(x))
    for i in eachindex(x)
        @. temp      = x > x[i]
           output[i] = sum(temp)
    end

    return output
end
 
@btime foo(ref($x));
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(50);   sx = SVector(x...)

function foo(x; output = Vector{Float64}(undef, length(x)))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end
 
@btime foo(ref($sx));
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(50);   sx = SVector(x...)

function foo(x; output = similar(x))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end
 
@btime foo(ref($sx));
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(50);   sx = SVector(x...)

function foo(x; output = MVector{length(x),eltype(x)}(undef))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end
 
@btime foo(ref($sx));
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(50)

function foo(x)
    output = SVector{length(x), eltype(x)}(undef)
    output = MVector{length(x), eltype(x)}(undef)

    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@code_warntype foo(x)                     # type unstable
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(50);   sx = SVector(x...)

function foo(x)
    
    output = MVector{length(x), eltype(x)}(undef)
    
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@code_warntype foo(sx)                    # type stable
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(50)

function foo(x, ::Val{N}) where N
    sx     = SVector{N, eltype(x)}(x)
    output = MVector{N, eltype(x)}(undef)

    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@code_warntype foo(x, Val(length(x)))     # type stable
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)
y = rand(100)

@btime sum($x .* $y)
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = tuple(rand(100)...)
y = tuple(rand(100)...)

@btime sum($x .* $y)
 
using BenchmarkTools
x2 = SVector(rand(100)...)
y2 = SVector(rand(100)...)

@btime sum($x .* $y)
 
