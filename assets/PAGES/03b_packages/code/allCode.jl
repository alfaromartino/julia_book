include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			PACKAGES
#
############################################################################
 
############################################################################
#
#			LOADING PACKAGES AND CALLING FUNCTIONS
#
############################################################################
 
x = [1,2,3]

import Statistics   #getting access to its functions will require the prefix `Statistics.`
Statistics.mean(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [1,2,3]

using Statistics    #no need to add the prefix `Statistics.` to call its functions (although it's possible to do so)
mean(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			BUILT-IN FUNCTIONS
#
############################################################################
 
+(2,3)      # same as 2 + 3
-(2,3)      # same as 2 - 3
*(2,3)      # same as 2 * 3
/(2,3)      # same as 2 / 3
^(2,3)      # same as 2 ^ 3
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			APPROACHES TO LOADING PACKAGES
#
############################################################################
 
####################################################
#	only a subset
####################################################
 
x = [1,2,3]

import Statistics: mean 
mean(x)                   # no prefix needed
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [1,2,3]

using Statistics: mean
mean(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	changing function names
####################################################
 
x = [1,2,3]

import Statistics as st
st.mean(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [1,2,3]

import Statistics: mean as average
average(x)                   # no prefix needed

using Statistics: mean as average
average(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			MACROS
#
############################################################################
 
# example
 
x   = [1,2] #hide 
y   = [1,2] #hide 
z   = Vector{Float64}(undef,2) #hide 
foo = log   #hide 

# both are equivalent
   z .= foo.(x .+ y)
@. z  = foo(x  + y)          # @. adds . to =, foo, and +
 
