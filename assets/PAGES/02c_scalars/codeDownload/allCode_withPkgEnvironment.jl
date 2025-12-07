####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


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
#			SCALARS
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
z = x > y         # same operation (don't interpreted it as 'z = x')
 
println(z)
 
