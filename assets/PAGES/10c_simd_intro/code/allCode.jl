include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random, StatsBase
 
############################################################################
#
#			INTRODUCTION TO SIMD (SINGLE INSTRUCTION, MULTIPLE DATA)
#
############################################################################
 
############################################################################
#
#			SIMD IN BROADCASTING
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(1_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = 2 / x[i]
    end

    return output
end
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(1_000_000)

foo(x) = 2 ./ x
@ctime foo($x) #hide
 
