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
#			PACKAGES
#
############################################################################
 
############################################################################
#
#			LOADING PACKAGES AND CALLING FUNCTIONS
#
############################################################################
 
x = [1,2,3]

import Statistics   #getting access to its functions will require the prefix `Statistics.`
Statistics.mean(x)
 



x = [1,2,3]

using Statistics    #no need to add the prefix `Statistics.` to call its functions (although it's possible to do so)
mean(x)
 



############################################################################
#
#			BUILT-IN FUNCTIONS
#
############################################################################
 
+(2,3)      # same as 2 + 3
-(2,3)      # same as 2 - 3
*(2,3)      # same as 2 * 3
/(2,3)      # same as 2 / 3
^(2,3)      # same as 2 ^ 3
 



############################################################################
#
#			APPROACHES TO LOADING PACKAGES
#
############################################################################
 
####################################################
#	only a subset
####################################################
 
x = [1,2,3]

import Statistics: mean 
mean(x)                   # no prefix needed
 



x = [1,2,3]

using Statistics: mean
mean(x)
 



####################################################
#	changing function names
####################################################
 
x = [1,2,3]

import Statistics as st
st.mean(x)
 



x = [1,2,3]

import Statistics: mean as average
average(x)                   # no prefix needed

using Statistics: mean as average
average(x)
 



############################################################################
#
#			MACROS
#
############################################################################
 
# example
 
x   = [1,2] 
y   = [1,2] 
z   = Vector{Float64}(undef,2) 
foo = log 

# both are equivalent
   z .= foo.(x .+ y)
@. z  = foo(x  + y)          # @. adds . to =, foo, and +
 
