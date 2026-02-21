include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			        SECTION: "SCALARS"
#
############################################################################
 
############################################################################
#
#   NUMBERS
#
############################################################################
 
x = 1       # `Int64`

y = 1.0     # `Float64`
z = 1.      # alternative notation for `1.0`
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 1000000
x = 1_000_000        # equivalent but more readable

y = 1000000.24            
y = 1_000_000.24     # _ can also be used with decimal numbers
 
####################################################
#	Float64
####################################################
 
x = 2.5

y = 10/0

z = 0/0
 
print_asis(x)   #hide
 
print_asis(y)   #hide
 
print_asis(z)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#   BOOLEAN VARIABLES
#
############################################################################
 
x = 2
y = 1

z = (x > y)       # is `x` greater than `y` ?
z = x > y         # equivalent (don't interpret it as 'z = x')
 
print_asis(z)       #hide
 
