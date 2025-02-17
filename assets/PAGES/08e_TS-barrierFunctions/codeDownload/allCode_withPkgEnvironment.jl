####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate results, we benchmark code through functions and interpolate each argument.
    # this means that benchmarking a function `foo(x)` makes use of `foo($x)`
using BenchmarkTools

# The following defines the macro `@fast_btime foo($x)`
    # `@fast_btime` is equivalent to `@btime` but substantially faster
    # if you want to use it, you should replace `@btime` with `@fast_btime`
    # by default, if `@fast_btime` doesn't provide allocations, it means there are none
using Chairmarks
macro fast_btime(ex)
    return quote
        display(@b $ex)
    end
end

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
# using StatsBase, Random
 
############################################################################
#
#           BARRIER FUNCTIONS
#
############################################################################
 
function foo(x)
    y = (x < 0) ?  0  :  x
    
    [y * i for i in 1:100]
end

@code_warntype foo(1)       # type stable
@code_warntype foo(1.)      # type UNSTABLE
 
operation(y) = [y * i for i in 1:100]

function foo(x)
    y = (x < 0) ?  0  :  x
    
    operation(y)
end

@code_warntype operation(1)    # barrier function is type stable
@code_warntype operation(1.)   # barrier function is type stable

@code_warntype foo(1)          # type stable
@code_warntype foo(1.)         # barrier-function solution
 

operation(y,i) = y * i 

function foo(x)
    y = (x < 0) ?  0  :  x
    
    [operation(y,i) for i in 1:100]
end

@code_warntype foo(1)          # type stable
@code_warntype foo(1.)         # type UNSTABLE
 
############################################################################
#
#           INTERPRETING `@code_warntype`
#
############################################################################
 
################
# EXAMPLE 1
################
 
x = ["a", 1]                     # variable with type 'Any'



function foo(x)
    y = x[2]
    
    [y * i for i in 1:100]
end
 
@code_warntype foo(x)
 


x = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(x)
    y = x[2]
    
    operation(y)
end
 
@code_warntype foo(x)
 


################
# EXAMPLE 2
################
 
x = ["a", 1]                     # variable with type 'Any'



function foo(x)
    y = 2 * x[2]
    
    [y * i for i in 1:100]
end
 
@code_warntype foo(x)
 
@btime foo($x)
 


x = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(x)
    y = 2 * x[2]
    
    operation(y)
end
 
@code_warntype foo(x)
 
@btime foo($x)
 


x = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(z)
    y = 2 * z
    
    operation(y)
end
 
@code_warntype foo(x[2])
 
@btime foo($x[2])
 
