include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
using Random
 
############################################################################
#
#			INDEPENDENCE OF ITERATIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = x[i] / 2 + x[i]^2 / 3
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = x[i] / 2 + x[i]^2 / 3
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

foo(x) = @. x / 2 + x^2 / 3
    
@ctime foo($x) #hide
 
############################################################################
#
#			REDUCTIONS
#
############################################################################
 
####################################################
#	automatic application of SIMD for Int in reductions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1:10, 10_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1:10, 10_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    @simd for a in x
        output += a
    end

    return output
end
@ctime foo($x) #hide
 
####################################################
#	no automatic application of SIMD for Float in reductions
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10_000_000)

function foo(x)
    output = 0.0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10_000_000)

function foo(x)
    output = 0.0

    @simd for a in x
        output += a
    end

    return output
end
@ctime foo($x) #hide
 
############################################################################
#
#			CONTIGUOUS BLOCKS OF MEMORY
#
############################################################################
 
x               = [20, 10, 30]

sorted_indices  = sortperm(x)
sorted_elements = x[sorted_indices]    # equivalent to `sort(x)`
 
print_asis(sorted_indices)
 
print_asis(sorted_elements)
 
####################################################
#	@simd is faster when elements are contiguous in memory
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)
y = @view x[sortperm(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)
y = @view x[sortperm(x)]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)
y = x[sortperm(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)
y = x[sortperm(x)]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	ultimately a race horse between not copying data vs SIMD efficiency
####################################################
 
# view faster here
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices) #hide
 
# copy is faster below
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = @view x[indices]
    output = 0.0

    for a in y
        output += a^(3/2)
    end

    return output
end
@ctime foo($x, $indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = x[indices]
    output = 0.0

    for a in y
        output += a^(3/2)
    end

    return output
end
@ctime foo($x, $indices) #hide
 
# typical example where copy may be faster is polynomies (simd applied automatically without @simd here)
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    for a in y
        output += a * 0.1 + a^2 * 0.2 - a^3 * 0.3 +  a^4 * 0.4
    end

    return output
end
@ctime foo($x,$indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a * 0.1 + a^2 * 0.2 - a^3 * 0.3 +  a^4 * 0.4
    end

    return output
end
@ctime foo($x,$indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = @views x[indices]
    output = 0.0

    for a in y
        output += a * 0.1 + a^2 * 0.2 - a^3 * 0.3 +  a^4 * 0.4
    end

    return output
end
@ctime foo($x,$indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = @views x[indices]
    output = 0.0

    @simd for a in y
        output += a * 0.1 + a^2 * 0.2 - a^3 * 0.3 +  a^4 * 0.4
    end

    return output
end
@ctime foo($x,$indices) #hide
 
####################################################
#	simd is faster with unit strides
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)
y = @view x[1:2:length(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)
y = @view x[1:2:length(x)]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)
y = x[1:2:length(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)
y = x[1:2:length(x)]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# overall effect
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)
indices = 1:2:length(x)

function foo(x, indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)
indices = 1:2:length(x)

function foo(x, indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices) #hide
 
