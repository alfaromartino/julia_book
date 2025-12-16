include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
using Random, LoopVectorization, StatsBase, Distributions
 
############################################################################
#
#			DISABLING BOUND INDEX COULD TRIGGER SIMD
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

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
x      = rand(1_000_000)
foo(x) = 2 ./ x

@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(1_000_000)
output = similar(x)

function foo!(output, x)
    for i in eachindex(x)
        output[i] = 2 / x[i]
    end
end
@ctime foo!($output,$x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(1_000_000)
output = similar(x)

function foo!(output, x)
    @inbounds @simd for i in eachindex(x)
        output[i] = 2 / x[i]
    end
end
@ctime foo!($output,$x) #hide
 
############################################################################
#
#			BRANCHLESS NEW 
#
############################################################################
 
# `ifelse` facilitates SIMD, `if` hinders it, while ternary operator attemps to select the best approach among the two
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        if (x[i] ≥ 0.5)
            output += (x[i] / 2)
        end
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if (x[i] ≥ 0.5)
            output += (x[i] / 2)
        end
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += ifelse((x[i] ≥ 0.5), (x[i] / 2), 0)
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += ifelse((x[i] ≥ 0.5), (x[i] / 2), 0)
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += (x[i] ≥ 0.5) ? (x[i] / 2) : 0
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += (x[i] ≥ 0.5) ? (x[i] / 2) : 0
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# ternary operator tries selects the best among the two approaches
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        if (x[i] ≥ 0.99)
            output += (log(x[i]))
        end
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if (x[i] ≥ 0.99)
            output += (log(x[i]))
        end
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += ifelse((x[i] ≥ 0.99), (log(x[i])), 0)
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += ifelse((x[i] ≥ 0.99), (log(x[i])), 0)
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += (x[i] ≥ 0.99) ? (log(x[i])) : 0
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += (x[i] ≥ 0.99) ? (log(x[i])) : 0
    end

    return output
end
@ctime foo($x) #hide
 
####################################################
#	sometimes ternary operator makes bad choices
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        if (x[i] ≥ 0.5)
            output += (log(x[i]))
        end
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if (x[i] ≥ 0.5)
            output += (log(x[i]))
        end
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += ifelse((x[i] ≥ 0.5), (log(x[i])), 0)
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += ifelse((x[i] ≥ 0.5), (log(x[i])), 0)
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += (x[i] ≥ 0.5) ? (log(x[i])) : 0
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += (x[i] ≥ 0.5) ? (log(x[i])) : 0
    end

    return output
end
@ctime foo($x) #hide
 
############################################################################
#
#			BITVECTOR for CONDITIONS
#
############################################################################
 
####################################################
#	with vector of conditions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x          = rand(1_000_000)
conditions = x .> 0.5

function foo(conditions,x)
    output            = similar(x)
    

    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(conditions[i], (x[i] / i), (x[i] * i))
    end

    return output
end
@ctime foo($conditions,$x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x          = rand(1_000_000)
conditions = x .> 0.5

function foo(conditions,x)
    output            = similar(x)
    vector_conditions = Vector(conditions)

    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(vector_conditions[i], (x[i] / i), (x[i] * i))
    end

    return output
end
@ctime foo($conditions,$x) #hide
 
############################################################################
#
#			ALGEBRAIC CONDITIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        
        
        output[i]       = ifelse(x[i] > 0.5, x[i] / i, x[i] * i)
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        condition_true  = x[i] > 0.5
        condition_false = !condition_true

        output[i]       = condition_true * (x[i] / i) + condition_false * (x[i] * i)
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        condition_true  = x[i] > 0.5
        condition_false = 1 - condition_true

        output[i]       = condition_true * (x[i] / i) + condition_false * (x[i] * i)
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
        
    @inbounds @simd for i in eachindex(x)
        condition_true = x[i] > 0.5


        output[i]      = (x[i] * i) + condition_true * (x[i] / i - x[i] * i)
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        condition_true = x[i] > 0.5
        output[i]      = x[i] * i                   # all filled with the value when false

        condition_true && (output[i] = x[i] / i)
    end

    return output
end
@ctime foo($x)
 
####################################################
#	MULTIPLE CONDITIONS
####################################################
 
####################################################
#	REMARK: @simd could be disregarded even with ifelse
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

branch1(a,b)   = a * b
branch2(a,b)   = a + b


foo(x,y)       = @. ifelse((x > 0.3) && (y < 0.6) && (x > y), branch1(x,y), branch2(x,y))
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

branch1(a,b)   = a * b
branch2(a,b)   = a + b


foo(x,y)       = @. ifelse((x > 0.3) *  (y < 0.6) *  (x > y), branch1(x,y), branch2(x,y))
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
#			HOW YOU WRITE CONDITIONS MAY MATTER
#
############################################################################
 
####################################################
#	REMARK: @simd could be applied even with `if` depending how we write conditions
####################################################
 
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
        if (x[i] > 0.3) * (y[i] < 0.6) * (x[i] > y[i])
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

    @inbounds @simd for i in eachindex(x)
        if condition(x[i],y[i])
            out += x[i]
        end
    end

    return out
end
@ctime foo($x,$y) #hide
 
############################################################################
#
#			MULTIPLE CONDITIONS
#
############################################################################
 
####################################################
#	easy computations favor SIMD
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        if condition(x[i],y[i])
            output += branch(x[i],y[i])
        end
    end

    return output
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += ifelse(condition(x[i],y[i]), branch(x[i],y[i]), 0)
    end

    return output
end
@ctime foo($x,$y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

condition(a,b) = (a > 0.3) && (b < 0.6) && (a > b)
branch(a,b)    =  a * b

function foo(x,y)
    output = 0.0

    @inbounds @simd for i in eachindex(x)
        output += condition(x[i],y[i]) ? branch(x[i],y[i]) : 0
    end

    return output
end
@ctime foo($x,$y) #hide
 
####################################################
#	but when computations are more intensive, compiler makes another choice
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

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
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

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
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

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
 
