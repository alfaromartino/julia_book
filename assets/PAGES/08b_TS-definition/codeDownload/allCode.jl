############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
    # uncomment if you don't have the package installed
using FastBenchmark
    

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
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
@code_warntype foo(1.0)
 



function foo(x)
    y = (x < 0) ?  0  :  x
    
    return [y * i for i in 1:100]
end
@code_warntype foo(1)
 
############################################################################
#
#           Yellow Warnings May Turn Red
#
############################################################################
 
function foo(x)
    y = (x < 0) ?  0  :  x
    
    y * 2
end
@code_warntype foo(1.0)
 



function foo(x)
    y = (x < 0) ?  0  :  x
    
    [y * i for i in 1:100]
end
@code_warntype foo(1.0)
 



function foo(x)
    y = (x < 0) ?  0  :  x    
    
    for i in 1:100
      y = y + i
    end
    
    return y
end
@code_warntype foo(1.0)
 



####################################################
#	remark: For-Loops and Yellow Warnings
####################################################
 
function foo()
    for i in 1:100
        i
    end
end
@code_warntype foo()
 
