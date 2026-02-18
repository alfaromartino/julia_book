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
#			        SECTION: "VARIABLES, TYPES, AND OPERATORS"
#
############################################################################
 
############################################################################
#
#   VARIABLES
#
############################################################################
 
####################################################
#	names for variables
####################################################
 
a         = 2
A         = 2       # variable `A` is different from `a`

new_value = 2       # underscores allowed

β         = 2       # Greek letters allowed

中國       = 2       # Chinese characters allowed   

x̄         = 2       # decorations allowed
x₁        = 2
ẋ         = 2

🐒        = 2       # emoticons allowed
 



####################################################
#	updating variables
####################################################
 
x  = 2

x  = x + 3    # 'x' now equals 5
 



####################################################
#	update operators
####################################################
 
x  = 2

x  = x + 3
x += 3        # equivalent

x  = x * 3
x *= 3        # equivalent

x  = x - 3
x -= 3        # equivalent
 
