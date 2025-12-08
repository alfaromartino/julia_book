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
#			MUTABLE AND IMMUTABLE OBJECTS
#
############################################################################
 
####################################################
#	examples
####################################################
 
x = [3,4,5]
 
x[1] = 0
 
println(x)
 



x = (3,4,5)
 
# x[1] = 0 #ERROR
 



x = "hello"
 
println(x[1])
 
# x[1] = "a" #ERROR
 



####################################################
#	modifying mutable collections
####################################################
 
x = [3,4]

push!(x, 5)       # add element 5 at the end
 
println(x)
 



x = [3,4,5]

pop!(x)           # delete last element
 
println(x)
 



x = (3,4,5)

# pop!(x)           # ERROR, as with push!(x, <some element>)
 
