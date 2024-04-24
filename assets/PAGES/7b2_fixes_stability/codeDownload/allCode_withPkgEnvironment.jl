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
# We use `foo(ref($x))` for more accurate benchmarks of the function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
############################################################################
#
#                           GLOBAL VARIABLES
#
############################################################################
 
x = 2

function foo(x) 
    y = 2 * x 
    z = log(y)

    return z
end

# foo(x)  # hide
@code_warntype foo(x)  # type stable
 
x = 2

function foo() 
    y = 2 * x 
    z = log(y)

    return z
end

foo()   # hide
@code_warntype foo() # type unstable
 
# all operations are type unstable (they're defined in the global scope)
x = 2

y = 2 * x 
z = log(y)
 
const a = 5
foo()   = 2 * a

foo()          # hide
@code_warntype foo()        # type stable
 
const b = [1, 2, 3]
foo()   = sum(b)

foo()          # hide
@code_warntype foo()        # type stable
 
