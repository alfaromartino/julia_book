include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random
 
############################################################################
#
#      NO SPECIALIZATION ON FUNCTIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y = map(f, x)
    
    sum(y)    
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y = map(f, x)
    

    sum(y)    
end
@btime foo(abs, $x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
print_compact(foo(abs, x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y = map(f, x)
    f(1)                # irrelevant computation to force specialization

    sum(y)
end
@btime foo(abs, $x) #hide
 
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
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)


function foo(f::F, x) where F
    y = map(f, x)
    

    sum(y)
end
@btime foo(abs, $x) #hide
 
print_compact(foo(abs, x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    y = map(f_tup[1], x)
    

    sum(y)
end
@btime foo($f_tup, $x) #hide
 
print_compact(foo(f_tup, x))
 
