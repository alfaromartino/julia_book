####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used when writing this note.
# It requires having all files (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml) in the same folder.

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# We use `foo(ref($x))` for more accurate benchmarks of any function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
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
    
    return [y * i for i in 1:100]
end

@code_warntype foo(1)       # type stable
@code_warntype foo(1.)      # type unstable
 
operation(y) = [y * i for i in 1:100]

function foo(x)
    y = (x < 0) ?  0  :  x
    
    return operation(y)
end

@code_warntype operation(1)    # barrier function - type stable
@code_warntype operation(1.)   # barrier function - type stable

@code_warntype foo(1)          # type stable
@code_warntype foo(1.)         # barrier-function solution
 

operation(y,i) = y * i 

function foo(x)
    y = (x < 0) ?  0  :  x
    
    return [operation(y,i) for i in 1:100]
end

@code_warntype foo(1)          # type stable
@code_warntype foo(1.)         # type unstable
 
############################################################################
#
#           INTERPRETING `@code_warntype`
#
############################################################################
 
################
# EXAMPLE 1
################
 
x            = ["a", 1]                     # variable with type 'Any'



function foo(x)
    y = x[2]
    
    return [y * i for i in 1:100]
end
 
@code_warntype foo(x)
 


x            = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(x)
    y = x[2]
    
    return operation(y)
end
 
@code_warntype foo(x)
 


################
# EXAMPLE 2
################
 
x            = ["a", 1]                     # variable with type 'Any'



function foo(x)
    y = 2 * x[2]
    
    return [y * i for i in 1:100]
end
 
@code_warntype foo(x)
 
@btime foo(ref($x))
 


x            = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(x)
    y = 2 * x[2]
    
    return operation(y)
end
 
@code_warntype foo(x)
 
@btime foo(ref($x))
 


x            = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(z)
    y = 2 * z
    
    return operation(y)
end
 
@code_warntype foo(x[2])
 
@btime foo(ref($x[2]))
 
