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
 
# necessary packages for this file
using Random
 
############################################################################
#
#			SLICE VIEWS TO DECREASE ALLOCATIONS
#
############################################################################
 
############################################################################
#
#			VIEW OF SLICES
#
############################################################################
 
x      = [1, 2, 3]

foo(x) = sum(x[1:2])           # allocations from the slice 'x[1:2]'
@ctime foo($x)
 



x      = [1, 2, 3]

foo(x) = sum(@view(x[1:2]))    # it doesn't allocate
@ctime foo($x)
 
####################################################
#	BOOLEAN INDEX
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(1_000)

foo(x) = @views sum(x[x .> 0.5])

@ctime foo($x)
 
############################################################################
#
#			COPYING DATA MAY BE FASTER
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x      = rand(100_000)

foo(x) = max.(x[1:2:length(x)], 0.5)

@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x      = rand(100_000)

foo(x) = max.(@view(x[1:2:length(x)]), 0.5)

@ctime foo($x)
 
