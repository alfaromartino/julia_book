include(joinpath(homedir(), "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
# using StatsBase, Random
 
############################################################################
#
#           BARRIER FUNCTIONS
#
############################################################################
 
function foo(x)
    y = (x < 0) ?  0  :  x
    
    return [y * i for i in 1:100]
end

@code_warntype foo(1)       # type stable
@code_warntype foo(1.)      # type unstable
 
operation(y) = [y * i for i in 1:100]

function foo(x)
    y = (x < 0) ?  0  :  x
    
    return operation(y)
end

@code_warntype operation(1)    # barrier function - type stable
@code_warntype operation(1.)   # barrier function - type stable

@code_warntype foo(1)          # type stable
@code_warntype foo(1.)         # barrier-function solution
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
operation(y,i) = y * i 

function foo(x)
    y = (x < 0) ?  0  :  x
    
    return [operation(y,i) for i in 1:100]
end

@code_warntype foo(1)          # type stable
@code_warntype foo(1.)         # type unstable
 
############################################################################
#
#           INTERPRETING `@code_warntype`
#
############################################################################
 
################
# EXAMPLE 1
################
 
x            = ["a", 1]                     # variable with type 'Any'



function foo(x)
    y = x[2]
    
    return [y * i for i in 1:100]
end
 
@code_warntype foo(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x            = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(x)
    y = x[2]
    
    return operation(y)
end
 
@code_warntype foo(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
################
# EXAMPLE 2
################
 
x            = ["a", 1]                     # variable with type 'Any'



function foo(x)
    y = 2 * x[2]
    
    return [y * i for i in 1:100]
end
 
@code_warntype foo(x)
 
@btime foo(ref($x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x            = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(x)
    y = 2 * x[2]
    
    return operation(y)
end
 
@code_warntype foo(x)
 
@btime foo(ref($x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x            = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(z)
    y = 2 * z
    
    return operation(y)
end
 
@code_warntype foo(x[2])
 
@btime foo(ref($x[2]))
 
