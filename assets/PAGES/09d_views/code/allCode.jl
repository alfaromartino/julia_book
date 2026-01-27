include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random
 
############################################################################
#
#			SLICE VIEWS TO DECREASE ALLOCATIONS
#
############################################################################
 
############################################################################
#
#			VIEW OF SLICES
#
############################################################################
 
x      = [1, 2, 3]

foo(x) = sum(x[1:2])           # allocations from the slice 'x[1:2]'
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1, 2, 3]

foo(x) = sum(@view(x[1:2]))    # it doesn't allocate
@ctime foo($x) #hide
 
####################################################
#	BOOLEAN INDEX
####################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(1_000)

foo(x) = @views sum(x[x .> 0.5])

@ctime foo($x) #hide
 
############################################################################
#
#			COPYING DATA MAY BE FASTER
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100_000)

foo(x) = max.(x[1:2:length(x)], 0.5)

@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100_000)

foo(x) = max.(@view(x[1:2:length(x)]), 0.5)

@ctime foo($x) #hide
 
