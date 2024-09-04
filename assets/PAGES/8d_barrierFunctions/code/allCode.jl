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
    
    [y * i for i in 1:100]
end

@code_warntype foo(1)       # type stable
@code_warntype foo(1.)      # type UNSTABLE
 
operation(y) = [y * i for i in 1:100]

function foo(x)
    y = (x < 0) ?  0  :  x
    
    operation(y)
end

@code_warntype operation(1)    # barrier function is type stable
@code_warntype operation(1.)   # barrier function is type stable

@code_warntype foo(1)          # type stable
@code_warntype foo(1.)         # barrier-function solution
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
operation(y,i) = y * i 

function foo(x)
    y = (x < 0) ?  0  :  x
    
    [operation(y,i) for i in 1:100]
end

@code_warntype foo(1)          # type stable
@code_warntype foo(1.)         # type UNSTABLE
 
############################################################################
#
#           INTERPRETING `@code_warntype`
#
############################################################################
 
################
# EXAMPLE 1
################
 
x = ["a", 1]                     # variable with type 'Any'



function foo(x)
    y = x[2]
    
    [y * i for i in 1:100]
end
 
@code_warntype foo(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(x)
    y = x[2]
    
    operation(y)
end
 
@code_warntype foo(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
################
# EXAMPLE 2
################
 
x = ["a", 1]                     # variable with type 'Any'



function foo(x)
    y = 2 * x[2]
    
    [y * i for i in 1:100]
end
 
@code_warntype foo(x)
 
@btime foo($x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(x)
    y = 2 * x[2]
    
    operation(y)
end
 
@code_warntype foo(x)
 
@btime foo($x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(z)
    y = 2 * z
    
    operation(y)
end
 
@code_warntype foo(x[2])
 
@btime foo($x[2])
 
