include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#           IN-PLACE FUNCTIONS
#
############################################################################
 
y = [0,0]

function foo(x)
    x[1] = 1
end
 
print_asis(y)       #hide
 
print_asis(foo(y))       #hide
 
print_asis(y)       #hide
 
####################################################
#	Functions Can't Reassign Variables
####################################################
 
x = 2

function foo(x)
    x = 3
end
 
print_asis(x)       #hide
 
print_asis(foo(x))       #hide
 
print_asis(x)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [1,2]

function foo()
    x = [0,0]
end
 
print_asis(x)       #hide
 
print_asis(foo(x))       #hide
 
print_asis(x)       #hide
 
############################################################################
#
#			BUILT-IN IN-PLACE FUNCTIONS
#
############################################################################
 
####################################################
#	single-argument function
####################################################
 
x      = [2, 1, 3]

output = sort(x)
 
print_asis(x)       #hide
 
print_asis(output)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [2, 1, 3]

sort!(x)
 
print_asis(x)       #hide
 
####################################################
#	multiple-argument Functions
####################################################
 
x      = [1, 2, 3]


output = map(a -> a^2, x)
 
print_asis(x)       #hide
 
print_asis(output)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1, 2, 3]
output = similar(x)             # we initialize `output`

map!(a -> a^2, output, x)       # we update `output`
 
print_asis(x)       #hide
 
print_asis(output)       #hide
 
############################################################################
#
#			MUTATIONS VIA FOR-LOOPS
#
############################################################################
 
x = [3,4,5]

function foo!(x)
    for i in 1:2
        x[i] = 0
    end
end
 
print_asis(foo!(x))       #hide
 
print_asis(x)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = Vector{Int64}(undef, 3)           # initialize a vector with 3 elements

function foo!(x)
    for i in eachindex(x)
        x[i] = 0
    end
end
 
print_asis(foo!(x))       #hide
 
print_asis(x)       #hide
 
