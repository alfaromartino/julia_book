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
#			TUPLES
#
############################################################################
 
############################################################################
#
#			DEFINITION OF TUPLES
#
############################################################################
 
x = (4,5,6)
x =  4,5,6           #alternative notation
 
println(x)
 
println(x[1])
 



x = (10,)    # not x = (10) (it'd be interpreted as x = 10)
 
println(x)
 
println(x[1])
 
############################################################################
#
#			TUPLES FOR ASSIGNMENTS
#
############################################################################
 
(x,y) = (4,5)
 x,y  =  4,5       #alternative notation
 
println(x)
 
println(y)
 



(x,y) = [4,5]
 x,y  = [4,5]      #alternative notation
 
println(x)
 
println(y)
 



