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


############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Chairmarks, BenchmarkTools
 
############################################################################
#
#           TYPE STABILITY WITH VECTORS
#
############################################################################
 

 

 

 

 

 

 
############################################################################
#
#           TYPE STABILITY WITH TUPLES
#
############################################################################
 
############################################################################
#  TUPLES ALLOWS HETEROGENEOUS TYPES OF ELEMENTS
############################################################################
 

 

 

 
############################################################################
#  VECTORS CONTAIN LESS INFORMATION THAN TUPLES
############################################################################
 

 

 

 

 

 
############################################################################
#  INFERENCE IS BY TYPE, NOT VALUE
############################################################################
 

 



