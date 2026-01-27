include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			DEFINING TYPE STABILITY
#
############################################################################
 
####################################################
#	An example
####################################################
 
x = [1, 2, 3]                  # `x` has type `Vector{Int64}`

@ctime sum($x[1:2])            # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [1, 2, "hello"]            # `x` has type `Vector{Any}`

@ctime sum($x[1:2])            # type UNSTABLE
 
############################################################################
#
#           Checking for type stability
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
#           Yellow Warnings May Turn Red
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
#	remark: For-Loops and Yellow Warnings
####################################################
 
function foo()
    for i in 1:100
        i
    end
end
@code_warntype foo() #hide
 
