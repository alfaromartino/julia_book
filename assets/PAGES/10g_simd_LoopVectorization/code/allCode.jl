include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
using Random, LazyArrays, LoopVectorization, StatsBase, Distributions
 
############################################################################
#
#			INDEPENDENCE OF ITERATIONS
#
############################################################################
 
####################################################
#	wrong result - this dependence is not allowed
####################################################
 
x = [0.1, 0.2, 0.3]

function foo!(x)
    for i in 2:length(x)
        x[i] = x[i-1] + x[i]
    end
end
foo!(x) #hide
print_compact(x) #hide
 
x = [0.1, 0.2, 0.3]

function foo!(x)
    @inbounds @simd for i in 2:length(x)
        x[i] = x[i-1] + x[i]
    end
end
foo!(x) #hide
print_compact(x) #hide
 
x = [0.1, 0.2, 0.3]

function foo!(x)
    @turbo for i in 2:length(x)
        x[i] = x[i-1] + x[i]
    end
end
foo!(x) #hide
print_compact(x) #hide
 
####################################################
#	you should apply it with independent iterations
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

foo(x)         = @turbo calculation.(x)
    
@ctime foo($x) #hide
 
############################################################################
#
#			REDUCTIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = 0.0
    
    for i in eachindex(x)
        output += calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = 0.0
    
    @inbounds @simd for i in eachindex(x)
        output += calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = 0.0
    
    @turbo for i in eachindex(x)
        output += calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
############################################################################
#
#			SPECIAL FUNCTIONS
#
############################################################################
 
####################################################
#	LOGARITHMIC
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = log(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = log(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = log(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = log(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x) #hide
 
####################################################
#	EXPONENTIAL
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = exp(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = exp(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = exp(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = exp(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x) #hide
 
####################################################
#	POWER FUNCTIONS
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a^4

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a^4

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a^4

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a^4

foo(x) = @turbo calculation.(x)    
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = sqrt(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = sqrt(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = sqrt(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = sqrt(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x) #hide
 
####################################################
#	TRIGONOMETRIC FUNCTIONS
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = sin(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = sin(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = sin(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = sin(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x) #hide
 
