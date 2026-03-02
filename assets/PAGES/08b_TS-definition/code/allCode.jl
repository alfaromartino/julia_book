include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			        SECTION: "DEFINING TYPE STABILITY"
#
############################################################################
 
############################################################################
#
#	AN EXAMPLE
#
############################################################################
 
x      = [1, 2, 3]          # `x` has type `Vector{Int64}`

foo(x) = sum(x[1:2])        # type stable with this `x`
@ctime sum($x[1:2]) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1, 2, "hello"]    # `x` has type `Vector{Any}`

foo(x) = sum(x[1:2])        # type UNSTABLE with this `x`  
@ctime sum($x[1:2]) #hide
 
############################################################################
#
#   CHECKING FOR TYPE STABILITY
#
############################################################################
 
function foo(x)
    y = (x < 0) ?  0  :  x
    
    return [y * i for i in 1:100]
end
@code_warntype foo(1.0) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo(x)
    y = (x < 0) ?  0  :  x
    
    return [y * i for i in 1:100]
end
@code_warntype foo(1) #hide
 
############################################################################
#
#   YELLOW WARNINGS MAY TURN RED
#
############################################################################
 
function foo(x)
    y = (x < 0) ?  0  :  x
    
    y * 2
end
@code_warntype foo(1.0) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo(x)
    y = (x < 0) ?  0  :  x
    
    [y * i for i in 1:100]
end
@code_warntype foo(1.0) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo(x)
    y = (x < 0) ?  0  :  x    
    
    for i in 1:100
      y = y + i
    end
    
    return y
end
@code_warntype foo(1.0) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	REMARK: For-Loops and Yellow Warnings
####################################################
 
function foo()
    for i in 1:100
        i
    end
end
@code_warntype foo() #hide
 
