include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			MUTABLE AND IMMUTABLE OBJECTS
#
############################################################################
 
####################################################
#	examples
####################################################
 
x = [3,4,5]
 
x[1] = 0
 
print_asis(x)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = (3,4,5)
 
# x[1] = 0 #ERROR   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = "hello"
 
print_asis(x[1])
 
# x[1] = "a" #ERROR   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	modifying mutable collections
####################################################
 
x = [3,4]

push!(x, 5)       # add element 5 at the end
 
print_asis(x)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [3,4,5]

pop!(x)           # delete last element
 
print_asis(x)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = (3,4,5)

# pop!(x)           # ERROR, as with push!(x, <some element>)
 
