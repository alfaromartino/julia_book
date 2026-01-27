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
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
############################################################################
#
#			SECTION: "TUPLES"
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
 



