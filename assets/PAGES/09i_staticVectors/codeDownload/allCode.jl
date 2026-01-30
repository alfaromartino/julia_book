############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
# necessary packages for this file
using Random, StaticArrays
 
############################################################################
#
#			SECTION: "STATIC VECTORS FOR SMALL COLLECTIONS"
#
############################################################################
 
############################################################################
#
#			DEFINING STATIC VECTORS
#
############################################################################
 
# all 'sx' define the same static vector '[3,4,5]'


sx = SVector(3,4,5)
sx = SVector{3, Int64}(3,4,5)
sx = SA[3,4,5]
sx = @SVector [i for i in 3:5]
 
println(sx)
 



# all 'sx' define a static vector with same elements as 'x'
x = collect(1:10)

sx = SVector(x...)
sx = SVector{length(x), eltype(x)}(x)
sx = SA[x...]
sx = @SVector [a for a in x]
 
println(sx, 10)
 



####################################################
#	slices
####################################################
 
x = collect(3:10) ; sx = SVector(x...)

# both define static vectors
slice1 = sx[:]
slice2 = sx[SA[1,2]]        # or slice2 = sx[SVector(1,2)]
 
println(slice1)
 
println(slice2)
 



x = collect(3:10) ; sx = SVector(x...)

# both define and ordinary vector
slice2 = sx[1:2]
slice2 = sx[[1,2]]
 
println(slice2)
 



############################################################################
#
#			SVECTORS DON'T ALLOCATE MEMORY AND ARE FASTER
#
############################################################################
 
####################################################
#	        svectors don't allocate
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(10)

function foo(x)
    a = x[1:2]              # 1 allocation (copy of slice)
    b = [3,4]               # 1 allocation (vector creation)

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(10)

@views function foo(x)
    a = x[1:2]              # 0 allocation (view of slice)
    b = [3,4]               # 1 allocation (vector creation) 

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(10);   tup = Tuple(x)

function foo(x)
    a = x[1:2]              # 0 allocation (slice of tuple)
    b = (3,4)               # 0 allocation (tuple creation)

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@ctime foo($tup)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(10);   sx = SA[x...]

function foo(x)
    a = x[SA[1,2]]          # 0 allocation (slice of static array)
    b = SA[3,4]             # 0 allocation (static array creation)

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@ctime foo($sx)
 



####################################################
#	impact on broadcasting
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(10)

foo(x) = sum(2 .* x)

@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(10);   sx = SVector(x...)

foo(x) = sum(2 .* x)

@ctime foo($sx)
 



####################################################
#	svectors vs built-in vectors
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x  = rand(10)

foo(x) = sum(a -> 10 + 2a +  3a^2, x)

@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x  = rand(10);  sx = SVector(x...);

foo(x) = sum(a -> 10 + 2a +  3a^2, x)

@ctime foo($sx)
 



############################################################################
#
#			SVECTOR TYPE AND ITS MUTABLE VARIANT
#
############################################################################
 
x      = [1,2,3]
sx     = SVector(x...)

#sx[1] = 0          # ERROR: setindex!(::SVector{3, Int64}, value, ::Int) is not defined.
 



x     = [1,2,3]
mx    = MVector(x...)

mx[1] = 0
 
println(mx, 10)
 



sx = SVector(1,2,3)

mx = similar(sx)        # it defines an MVector with undef elements
 
println(mx, 10)
 



############################################################################
#
#			TYPE STABILITY: SIZE IS PART OF THE STATIC VECTOR'S TYPE
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(50)

function foo(x)
    
    output = MVector{length(x), eltype(x)}(undef)

    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@code_warntype foo(x)                     # type unstable
 



Random.seed!(123)       #setting seed for reproducibility
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
 



Random.seed!(123)       #setting seed for reproducibility
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
 



############################################################################
#
#			PERFORMANCE COMPARISONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x  = rand(10)
sx = SVector(x...);  mx = MVector(x...)

foo(x) = sum(a -> 10 + 2a +  3a^2, x)
 
@ctime foo($x)
 
@ctime foo($sx)
 
@ctime foo($mx)
 



Random.seed!(123)       #setting seed for reproducibility
x  = rand(10)
sx = SVector(x...);  mx = MVector(x...)

foo(x) = 10 + 2x +  3x^2
 
@ctime foo.($x)
 
@ctime foo.($sx)
 
@ctime foo.($mx)
 



############################################################################
#
#			STATIC VECTORS VS PRE-ALLOCATIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(50)

function foo(x; output = similar(x))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end
 
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(50)

function foo(x; output = similar(x), temp = similar(x))
    for i in eachindex(x)
        @. temp      = x > x[i]
           output[i] = sum(temp)
    end

    return output
end
 
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(50);   sx = SVector(x...)

function foo(x; output = Vector{Float64}(undef, length(x)))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end
 
@ctime foo($sx)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(50);   sx = SVector(x...)

function foo(x; output = similar(x))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end
 
@ctime foo($sx)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(50);   sx = SVector(x...)

function foo(x; output = MVector{length(x),eltype(x)}(undef))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end
 
@ctime foo($sx)
 
