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
#			CONDITIONAL STATEMENTS
#
############################################################################
 
############################################################################
#
#			IF-THEN STATEMENTS
#
############################################################################
 
x = 5

if x > 0
    println("x is positive")
end
 



x = 5

(x > 0) && (println("x is positive"))
 



x = 5

(x ≤ 0) || (println("x is positive"))
 



############################################################################
#
#			IF-ELSE STATEMENTS
#
############################################################################
 
x = 5

if x > 0
    println("x is positive")
else
    println("x is not positive")
end
 



x = 5

x > 0 ? println("x is positive") : println("x is not positive")
 



####################################################
#	ifelse function
####################################################
 
x                     = [4, 2, -6]

are_elements_positive = ifelse.(x .> 0, true, false)
println(are_elements_positive)
 



x                     = [4, 2, -6]

x_absolute_value      = ifelse.(x .≥ 0, x, -x)
println(x_absolute_value)
 



############################################################################
#
#			IF-ELSE-IF STATEMENTS
#
############################################################################
 
x = -10

if x > 0
    println("x is positive")
elseif x == 0
    println("x is zero")
end
 



x = -10

if x > 0
    println("x is positive")
elseif x == 0
    println("x is zero")
else
    println("x is negative")
end
 
