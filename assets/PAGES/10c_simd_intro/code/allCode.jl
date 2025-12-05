include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
using Random, LazyArrays, LoopVectorization, StatsBase, Distributions
 
############################################################################
#
#			SIMD (SINGLE INSTRUCTION, MULTIPLE DATA)
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(1_000_000)

foo(x) = 2 ./ x
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @simd for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo!(x)
    for i in eachindex(x)
        x[i] = 2 / x[i]
    end
end
@ctime foo!($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo!(x)
    @inbounds for i in eachindex(x)
        x[i] = 2 / x[i]
    end
end
@ctime foo!($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo!(x)
    @inbounds @simd for i in eachindex(x)
        x[i] = 2 / x[i]
    end
end
@ctime foo!($x) #hide
 
############################################################################
#
#			CONTIGUOUS BLOCKS OF MEMORY
#
############################################################################
 
####################################################
#	@simd is faster when elements are contiguous in memory
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = x .> 0.5
y       = view(x, indices)

function foo(y)
    output = 0.0

    for i in eachindex(y)
        output += 2 * y[i]
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    for i in eachindex(y)
        output += 2 * y[i]
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = x .> 0.5
y       = view(x, indices)

function foo(y)
    output = 0.0

    @simd for i in eachindex(y)
        output += 2 * y[i]
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for i in eachindex(y)
        output += 2 * y[i]
    end

    return output
end
@ctime foo($y) #hide
 
####################################################
#	performance is a race horse between not copying data vs SIMD benefits
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(5_000_000)

function foo(x)
    output  = 0.0

    indices = x .> 0.5
    y       = view(x, indices)

    for i in eachindex(y)
        output += 2 * y[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(5_000_000)

function foo(x)
    output  = 0.0
    
    indices = x .> 0.5
    y       = view(x, indices)

    for i in eachindex(y)
        output += 2 * y[i]
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(5_000_000)

function foo(x)
    output  = 0.0
    
    indices = x .> 0.5
    y       = view(x, indices)

    @simd for i in eachindex(y)
        output += 2 * y[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(5_000_000)

function foo(x)
    output  = 0.0

    indices = x .> 0.5
    y       = view(x, indices)

    @simd for i in eachindex(y)
        output += 2 * y[i]
    end

    return output
end
@ctime foo($x) #hide
 
############################################################################
#
#			REDUCTIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1:10, 2_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1:10, 2_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    @simd for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x) #hide
 
####################################################
#	no automatic application of SIMD for Float in reductions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(2_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(2_000_000)

function foo(x)
    output = 0.0

    @simd for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x) #hide
 
############################################################################
#
#			DISABLING BOUND INDEX COULD TRIGGER SIMD
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] += 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100_000)

function foo(x)
    output = similar(x)

    @simd for i in eachindex(x)
        output[i] += 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100_000)

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] += 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] += 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide
 
############################################################################
#
#			BRANCHLESS
#
############################################################################
 
# with branches
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    out = 0.0

    for i in eachindex(x)
        if condition(x[i],y[i])
            out += branch(x[i],y[i])
        end
    end

    return out
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    out = 0.0

    @inbounds @simd for i in eachindex(x)
        if condition(x[i],y[i])
            out += branch(x[i],y[i])
        end
    end

    return out
end
@ctime foo($x,$y) #hide
 
# branchless
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    out = 0.0

    for i in eachindex(x)
        out += ifelse(condition(x[i],y[i]), branch(x[i],y[i]), 0)
    end

    return out
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    out = 0.0

    @inbounds @simd for i in eachindex(x)
        out += ifelse(condition(x[i],y[i]), branch(x[i],y[i]), 0)
    end

    return out
end
@ctime foo($x,$y) #hide
 
# compiler decides
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    out = 0.0

    for i in eachindex(x)
        out += condition(x[i],y[i]) ? branch(x[i],y[i]) : 0
    end

    return out
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    out = 0.0

    @inbounds @simd for i in eachindex(x)
        out += condition(x[i],y[i]) ? branch(x[i],y[i]) : 0
    end

    return out
end
@ctime foo($x,$y) #hide
 
####################################################
#	but when computations are more intensive, compiler makes another choice
####################################################
 
# with branches
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a)      = exp(a) / 3 + log(a) / 2

function foo(x,y)
    out = 0.0

    for i in eachindex(x)
        if condition(x[i],y[i])
            out += branch(x[i])
        end
    end

    return out
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a)      = exp(a) / 3 + log(a) / 2

function foo(x,y)
    out = 0.0

    @inbounds @simd for i in eachindex(x)
        if condition(x[i],y[i])
            out += branch(x[i])
        end
    end

    return out
end
@ctime foo($x,$y) #hide
 
# branchless
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a)      = exp(a) / 3 + log(a) / 2

function foo(x,y)
    out = 0.0

    for i in eachindex(x)
        out += ifelse(condition(x[i],y[i]), branch(x[i]), 0)
    end

    return out
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a)      = exp(a) / 3 + log(a) / 2

function foo(x,y)
    out = 0.0

    @inbounds @simd for i in eachindex(x)
        out += ifelse(condition(x[i],y[i]), branch(x[i]), 0)
    end

    return out
end
@ctime foo($x,$y) #hide
 
# compiler decides
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a)      = exp(a) / 3 + log(a) / 2

function foo(x,y)
    out = 0.0

    for i in eachindex(x)
        out += condition(x[i],y[i]) ? branch(x[i]) : 0
    end

    return out
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(100_000)
y              = rand(100_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a)      = exp(a) / 3 + log(a) / 2

function foo(x,y)
    out = 0.0

    @inbounds @simd for i in eachindex(x)
        out += condition(x[i],y[i]) ? branch(x[i]) : 0
    end

    return out
end
@ctime foo($x,$y) #hide
 
############################################################################
#
#			CONDITIONS AS ALGEBRAIC OPERATIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                 = rand(1_000_000)
y                 = rand(1_000_000)


function foo(x,y)
    out = 0.0

    @inbounds @simd for i in eachindex(x)
        if ((x[i] > 0.3) && (y[i] < 0.6) && (x[i] > y[i]))
            out += x[i]
        end
    end

    return out
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                 = rand(1_000_000)
y                 = rand(1_000_000)


function foo(x,y)
    out = 0.0

    @inbounds @simd for i in eachindex(x)
        if (x[i] > 0.3) *  (y[i] < 0.6) *  (x[i] > y[i])
            out += x[i]
        end
    end

    return out
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                 = rand(1_000_000)
y                 = rand(1_000_000)
condition(a,b)    = (a > 0.3) && (b < 0.6) && (a > b)

function foo(x,y)
    out = 0.0

    for i in eachindex(x)
        if condition(x[i],y[i])
            out += x[i]
        end
    end

    return out
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

branch1(a,b)   = a * b
branch2(a,b)   = a + b


foo(x,y)       = @. ifelse((x > 0.3) *  (y < 0.6) *  (x > y), branch1(x,y), branch2(x,y))
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

branch1(a,b)   = a * b
branch2(a,b)   = a + b


foo(x,y)       = @. ifelse((x > 0.3) && (y < 0.6) && (x > y), branch1(x,y), branch2(x,y))
@ctime foo($x,$y) #hide
 
x              = rand(1_000_000)
y              = rand(1_000_000)

branch1(a,b)   = a * b
branch2(a,b)   = a + b
condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)

foo(x,y)       = @. ifelse(condition(x,y), branch1(x,y), branch2(x,y))
@ctime foo($x,$y) #hide
 
############################################################################
#
#			other cases
#
############################################################################
 
####################################################
#	@simd could be disregarded
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

condition(a)     = (a > 0.1) && (a < 0.7)
branch1(a)       =  a * 1.1
branch2(a)       =  a * 1.2

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = if condition(x[i])
            branch1(x[i])
        else
            branch2(x[i])
        end
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

condition(a)     = (a > 0.1) * (a < 0.7)
branch1(a)       =  a * 1.1
branch2(a)       =  a * 1.2

function foo(x)
    output = similar(x)

    @simd for i in eachindex(x)
        output[i] = ifelse((condition(x[i])), branch1(x[i]), branch2(x[i]))
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

condition_alt(a) = (a > 0.1) * (a < 0.7)
branch1(a)       =  a * 1.1
branch2(a)       =  a * 1.2

function foo(x)
    output = similar(x)

    @simd for i in eachindex(x)
        output[i] = ifelse((condition_alt(x[i])), branch1(x[i]), branch2(x[i]))
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

condition(a)     = (a > 0.1) && (a < 0.7)
branch1(a)       =  a * 1.1
branch2(a)       =  a * 1.2

function foo(x)
    output = similar(x)

    @inbounds for i in eachindex(x)
        output[i] = if condition(x[i])
            branch1(x[i])
        else
            branch2(x[i])
        end
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

condition(a)     = (a > 0.1) && (a < 0.7)
branch1(a)       =  a * 1.1
branch2(a)       =  a * 1.2

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = if condition(x[i])
            branch1(x[i])
        else
            branch2(x[i])
        end
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

condition(a)     = (a > 0.1) && (a < 0.7)
branch1(a)       =  a * 1.1
branch2(a)       =  a * 1.2

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = condition_alt(x[i]) ? branch1(x[i]) : branch2(x[i])        
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

condition(a)     = (a > 0.1) && (a < 0.7)
branch1(a)       =  a * 1.1
branch2(a)       =  a * 1.2

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = condition(x[i]) ? branch1(x[i]) : branch2(x[i])        
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

condition(a)     = (a > 0.1) && (a < 0.7)
branch1(a)       =  a * 1.1
branch2(a)       =  a * 1.2

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = ifelse(condition(x[i]), branch1(x[i]), branch2(x[i]))
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

condition(a)     = (a > 0.1) && (a < 0.7)
branch1(a)       =  a * 1.1
branch2(a)       =  a * 1.2

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(condition(x[i]), branch1(x[i]), branch2(x[i]))
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

foo(a) = ifelse(condition_alt(a), branch1(a), branch2(a))

@ctime foo.($x) #hide
 
