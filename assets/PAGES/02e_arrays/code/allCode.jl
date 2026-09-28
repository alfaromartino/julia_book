include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			VECTORS
#
############################################################################
 
x = [1, 2, 3]          #= column-vector (defined using commas or semicolons)
                           Vector{Int64} (alias for Array{Int64, 1}) =# 

x = [1; 2; 3]          # equivalent notation to define `x`
print_asis(x)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [4, 5, 6]
 
print_asis(x)   #hide
 
print_asis(x[2])   #hide
 
print_asis(x[:])   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [4, 5, 6, 7, 8]
 
print_asis(x)   #hide
 
print_asis(x[[1,3]])   #hide
 
#print_asis(x[1,3])   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [4, 5, 6, 7, 8]
 
print_asis(x)   #hide
 
print_asis(x[1:2])   #hide
 
print_asis(x[1:2:5])   #hide
 
print_asis(x[begin:end])   #hide
 
############################################################################
#
#			MATRICES (optional)
#
############################################################################
 
X = [1 2 ; 3 4]       #= matrix as a collection of row-vectors, separated by semicolons
                         Matrix{Int64} (alias for Array{Int64, 2})=#

X = [ [1,3] [2,4] ]   # identical to `X`, but defined through a collection of column-vectors

Y = [1 2 3]           #= row-vector (defined without commas)
                         Matrix{Int64} (alias for Array{Int64, 2}) =#
 
print_asis(X)   #hide
 
print_asis(Y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
X = [5 6 ; 7 8] # matrix

Y = [4 5 6]     # row-vector
 
print_asis(X)   #hide
 
print_asis(X[2,1])   #hide
 
print_asis(X[1,:])   #hide
 
print_asis(X[:,2])   #hide
 
print_asis(Y[2])   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
X = [5 6 ; 7 8]
 
print_asis(X)   #hide
 
print_asis(X[[1,2],1])   #hide
 
print_asis(X[1:2,1])   #hide
 
print_asis(X[begin:end,1])   #hide
 
