include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			TUPLES
#
############################################################################
 
############################################################################
#
#			DEFINITION OF TUPLES
#
############################################################################
 
x = (4,5,6)
x =  4,5,6           #alternative notation
 
print_asis(x)   #hide
 
print_asis(x[1])   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = (10,)    # not x = (10) (it'd be interpreted as x = 10)
 
print_asis(x)   #hide
 
print_asis(x[1])   #hide
 
############################################################################
#
#			TUPLES FOR ASSIGNMENTS
#
############################################################################
 
(x,y) = (4,5)
 x,y  =  4,5       #alternative notation
 
print_asis(x)   #hide
 
print_asis(y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
(x,y) = [4,5]
 x,y  = [4,5]      #alternative notation
 
print_asis(x)   #hide
 
print_asis(y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
