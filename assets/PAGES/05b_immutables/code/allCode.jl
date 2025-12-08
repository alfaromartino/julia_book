include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			ASSIGNMENTS VS MUTATION
#
############################################################################
 
####################################################
#	mutating all elements vs assignment
####################################################
 
x    = [4,5]

x[:] = [0,0]
 
print_asis(x)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	alias vs copy
####################################################
 
x = 2   #'x' points to an object with value 2
y = x   #'y' points to the same object as 'x' (do not interpret it as 'y' pointing to 'x') 

x = 4   #'x' now points to another object (but 'y' still points to the object holding 2)
 
print_asis(x)   #hide
 
print_asis(y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	Two variables may contain identical elements and yet refer to different objects
####################################################
 
x = [4,5]

y = x
 
print_asis(x == y)      #hide
 
print_asis(x === y)      #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [4,5]

y = [4,5]
 
print_asis(x == y)      #hide
 
print_asis(x === y)      #hide
 
####################################################
#	variable 'y' as an alias
####################################################
 
x    = [4,5]
y    = x

x[1] = 0
 
print_asis(x)   #hide
 
print_asis(y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	variable 'y' as a copy
####################################################
 
x    = [4,5]
y    = x

x[1] = 0
 
print_asis(x)   #hide
 
print_asis(y)   #hide
 
