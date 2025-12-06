include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random
 
############################################################################
#
#      NO SPECIALIZATION ON FUNCTIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x         = rand(100)

foo(f, x) = f.(x)
@code_warntype foo(abs, x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    
    f.(x)
end
@ctime foo(abs, $x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
print_compact(foo(abs, x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    f(1)                # irrelevant computation to force specialization
    f.(x)
end
@ctime foo(abs, $x) #hide
 
print_compact(foo(abs, x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			SOLUTIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)


function foo(f::F, x) where F
    f.(x)
end
@ctime foo(abs, $x) #hide
 
print_compact(foo(abs, x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    f_tup[1].(x)    
end
@ctime foo($f_tup, $x) #hide
 
print_compact(foo(f_tup, x))
 
