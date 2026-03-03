############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
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
@ctime sum($x[1:2])
 



x      = [1, 2, "hello"]    # `x` has type `Vector{Any}`

foo(x) = sum(x[1:2])        # type UNSTABLE with this `x`  
@ctime sum($x[1:2])
 
############################################################################
#
#   CHECKING FOR TYPE STABILITY
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
#   YELLOW WARNINGS MAY TURN RED
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
#	REMARK: For-Loops and Yellow Warnings
####################################################
 
function foo()
    for i in 1:100
        i
    end
end
@code_warntype foo()
 
