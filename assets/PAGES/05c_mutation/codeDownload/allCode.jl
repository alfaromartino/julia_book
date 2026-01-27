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
#			SECTION: "ASSIGNMENTS VS MUTATIONS"
#
############################################################################
 
####################################################
#	Mutating All Elements vs Assignment
####################################################
 
x    = [4,5]

x[:] = [0,0]
 
println(x)
 



####################################################
#	alias vs copy
####################################################
 
x = 2   #'x' points to an object with value 2
y = x   #'y' points to the same object as 'x' (do not interpret it as 'y' pointing to 'x') 

x = 4   #'x' now points to another object (but 'y' still points to the object holding 2)
 
println(x)
 
println(y)
 
####################################################
#	Two variables may contain identical elements and yet refer to different objects
####################################################
 
x = [4,5]

y = x
 
println( x == y)
 
println( x === y)
 



x = [4,5]

y = [4,5]
 
println( x == y)
 
println( x === y)
 
####################################################
#	variable 'y' as an alias
####################################################
 
x    = [4,5]
y    = x

x[1] = 0
 
println(x)
 
println(y)
 
####################################################
#	variable 'y' as a copy
####################################################
 
x    = [4,5]
y    = copy(x)

x[1] = 0
 
println(x)
 
println(y)
 
