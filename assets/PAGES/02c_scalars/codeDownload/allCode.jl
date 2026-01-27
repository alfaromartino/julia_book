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
#			SECTION: "SCALARS"
#
############################################################################
 
####################################################
#	numbers
####################################################
 
x = 1       # `Int64`

y = 1.0     # `Float64`
z = 1.      # alternative notation for `1.0`
 



x = 1000000
y = 1_000_000        # equivalent to `x` and more readable

x = 1000000.24            
y = 1_000_000.24     # _ can be used with decimal numbers
 
####################################################
#	Float64
####################################################
 
x = 2.5

y = 10/0

z = 0/0
 
println(x)
 
println(y)
 
println(z)
 



####################################################
#	boolean variables
####################################################
 
x = 2
y = 1

z = (x > y)       # is `x` greater than `y` ?
z = x > y         # equivalent (don't interpret it as 'z = x')
 
println(z)
 
