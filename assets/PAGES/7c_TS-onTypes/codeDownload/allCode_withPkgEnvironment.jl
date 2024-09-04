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
# For more accurate benchmarks, we interpolate variable `x` as in `foo($x)`
using BenchmarkTools



############################################################################
#
#                           START OF THE CODE 
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
 

 



