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
 
# necessary packages for this file
using Statistics
 
############################################################################
#
#                           GLOBAL VARIABLES
#
############################################################################
 
x      = rand(10)
foo(x) = sum(x)

@btime foo(ref($x))
#@code_warntype foo() # hide
 
x     = rand(10)
foo() = sum(x)

@btime foo()
#@code_warntype foo() # hide
 
x     = rand(10)

@btime begin
    sum(x)
end
#@code_warntype foo() # hide
 
using Statistics

x      = rand(10)
foo(x) = sum(x) * prod(x) * mean(x) * std(x)

@btime foo(ref($x))
 
using Statistics

x      = rand(10)
foo()  = sum(x) * prod(x) * mean(x) * std(x)

@btime foo()
 
x  = Vector{Any}(undef, 10)
x .= 1

sum(x)          # hide
@code_warntype sum(x)           # type unstable
 
x  = [1, 2, "hello"]            # x will be identified as Vector{Any}, due to the string element


sum(x[1:2])     # hide
@code_warntype sum(x[1:2])      # type unstable
 
x  = Vector{Number}(undef, 10)  # x is defined as Vector{Number}
x .= 1

sum(x)          # hide 
@code_warntype sum(x)           # type unstable
 
x  = Vector{Int64}(undef, 10)   # x is defined as Vector{Int64}
x .= 1

sum(x)          # hide
@code_warntype sum(x)           # type stable
 
x  = Vector{Float64}(undef, 10)
x .= 1                          # 1 is converted to 1.0 due to x's type 

sum(x)          # hide
@code_warntype sum(x)           # type stable
 
x  = [1, 2, 2.5]                # x is converted to Vector{Float64}    


sum(x)          # hide
@code_warntype sum(x)           # type stable
 
x  = [1.0, 2, 2.0]              # x is converted to Vector{Float64}


sum(x)          # hide
@code_warntype sum(x)           # type stable
 
