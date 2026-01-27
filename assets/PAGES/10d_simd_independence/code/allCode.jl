include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random
 
############################################################################
#
#			SIMD: INDEPENDENCE OF ITERATIONS
#
############################################################################
 
############################################################################
#
#			INDEPENDENCE OF ITERATIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = x[i] / 2 + x[i]^2 / 3
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = x[i] / 2 + x[i]^2 / 3
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(1_000_000)

foo(x) = @. x / 2 + x^2 / 3
    
@ctime foo($x) #hide
 
############################################################################
#
#			A SPECIAL CASE OF DEPENDENCE: REDUCTIONS
#
############################################################################
 
####################################################
#	automatic application of SIMD for Int in reductions
####################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(1:10, 10_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(1:10, 10_000_000)   # random integers between 1 and 10

function foo(x)
    output = 0

    @simd for a in x
        output += a
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	no automatic application of SIMD for Float in reductions
####################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(10_000_000)

function foo(x)
    output = 0.0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(10_000_000)

function foo(x)
    output = 0.0

    @simd for a in x
        output += a
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	Why Floating Points Are Treated Differently
####################################################
 
x = 0.1 + (0.2 + 0.3)
print_asis(x)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = (0.1 + 0.2) + 0.3
print_asis(x)   #hide
 
