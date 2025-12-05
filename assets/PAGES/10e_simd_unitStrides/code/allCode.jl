include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
using Random
 
############################################################################
#
#			PREVIEW CONCEPTS FOR EXAMPLES
#
############################################################################
 
x         = [10, 20, 30]

indices   = sortperm(x)
elements  = x[indices]    # equivalent to `sort(x)`
 
print_asis(indices)
 
print_asis(elements)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [20, 10, 30]

indices   = x .> 15
elements  = x[indices]
 
print_asis(indices)
 
print_asis(elements)
 
x         = [2, 3, 4, 5, 6]

indices_1 = 1:length(x)         # unit strides, equivalent to 1:1:length(x)
indices_2 = 1:2:length(x)       # strides two
 
print_asis(collect(indices_1))
 
print_asis(collect(indices_2))
 
############################################################################
#
#			CONTIGUOUS BLOCKS OF MEMORY
#
############################################################################
 
####################################################
#	@simd is faster when elements are contiguous in memory
####################################################
 
####################################################
#	example 1
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = sortperm(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = sortperm(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = sortperm(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = sortperm(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
####################################################
#	example 2
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = x .> 0.5
y       = @view x[indices]

function foo(y)
    output = 0.0

    for a in y
        output += a
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

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)

indices = x .> 0.5
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
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

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
####################################################
#	choice between copy or views doesn't matter if access is contiguous
#       hence, views are faster as they avoid memory allocations
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)

indices = 1:length(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)

indices = 1:length(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)

indices = 1:length(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)

indices = 1:length(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
####################################################
#	a copy is faster when multiple operations with the same object are performed
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = @view x[indices]
    output1, output2, output3 = (0.0 for _ in 1:3)

    @simd for a in y
        output1 += a^(3/2)
        output2 += a / 3
        output3 += a * 2.5
    end

    return output1, output2, output3
end
@ctime foo($x, $indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = x[indices]
    output1, output2, output3 = (0.0 for _ in 1:3)

    @simd for a in y
        output1 += a^(3/2)
        output2 += a / 3
        output3 += a * 2.5
    end

    return output1, output2, output3
end
@ctime foo($x, $indices) #hide
 
# ultimately a race horse between not copying data vs SIMD efficiency
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = @view x[indices]
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(1_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices) #hide
 
####################################################
#	example 2
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(10_000)
indices = x .> 0.5
y       = @view x[indices]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(10_000)
indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(10_000)
indices = x .> 0.5
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(10_000)
indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide
 
# ultimately a race horse between not copying data vs SIMD efficiency
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(10_000)
indices = x .> 0.5

function foo(x,indices)
    y      = @view x[indices]
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(10_000)
indices = x .> 0.5

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(10_000)
indices = x .> 0.5

function foo(x,indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices) #hide
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(10_000)
indices = x .> 0.5

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices) #hide
 
####################################################
#	ultimately a race horse between not copying data vs SIMD efficiency
####################################################
 
# view faster here
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)
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
x       = rand(5_000_000)
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

    @simd for a in y
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

    @simd for a in y
        output += a^(3/2)
    end

    return output
end
@ctime foo($x, $indices) #hide
 
############################################################################
#
#			UNIT STRIDES
#
############################################################################
 
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
 
############################################################################
#
#			another example of unit strides
#
############################################################################
 
# vectors we'll use
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x_size = 1_000_000

x = rand(x_size)

y = zeros(eltype(x),x_size * 2)
    temp  = view(y, 2:2:length(y))
    temp .= x
 
print_asis(x[1:3])
 
print_asis(y[1:6],12)
 
# simd is faster with unit strides
 
function foo(x)
    output = 0.0

    @inbounds @simd for i in 1:length(x)
        output += x[i]
    end

    return output
end
@ctime foo($x) #hide
 
function foo(y)
    output = 0.0

    @inbounds @simd for i in 2:2:length(y)
        output += y[i]
    end

    return output
end
@ctime foo($y) #hide
 
####################################################
#	copies vs views - simd is faster with unit strides
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
 
