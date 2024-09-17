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
# for more accurate results, we perform benchmarks through functions and interpolate each variable.
# this means that benchmarking a function `foo(x)` should be `foo($x)`
using BenchmarkTools
 
# necessary packages for this file
# using StatsBase, Random
 
############################################################################
#
#           MUTATIONS VIA VECTORS
#
############################################################################
 
x         = [1, 2, 3, 4]

x[3]      = 30
x[4]      = 40
 


x         = [1, 2, 3, 4]


x[x .≥ 3] = x[x .≥ 3] .* 10
 


x         = [1, 2, 3, 4]


x[3:end]  = [x[i] * 10 for i in 3:length(x)]
 


x         = [1, 2, 3, 4]


x[3:end]  = [30, 40]
 


####################################################
#	WARNING: MUTATION VS ASSIGNMENT
####################################################
 
# assignment
 
x    = [1, 2, 3, 4]

x    = x .* 10
 


# mutation
 
x    = [1, 2, 3, 4]

x[:] = x .* 10
 


############################################################################
#
#           MUTATION VIA .=
#
############################################################################
 


x          = [-1, -2, 3, 4]

x[x .< 0] .= 0
 


x          = [-1, -2, 3, 4]

x[x .< 0] .= zeros(length(x[x .< 0]))           # identical output
 


x          = [-1, -2, 3, 4]

x[x .< 0]  = zeros(length(x[x .< 0]))
 


############################################################################
#
#           COMBINING .= and view
#
############################################################################
 
x          = [-1, -2, 1, 2]


x[x .< 0] .= 0
 


x          = [-1, -2, 1, 2]

slice      = view(x, x .< 0)
slice     .= 0
 


####################################################
#	same operations allowed
####################################################
 
x      = [1, 2, 3, 4]
slice  = view(x, x .≥ 3)

slice .= slice .* 10              # same operation as 'x[x .≥ 3] = x[x .≥ 3] .* 10'
 


x      = [1, 2, 3, 4]
slice  = view(x, x .≥ 3)

slice .= [i * 10 for i in [3,4]]  # same operation as 'x[x .≥ 3] = [i * 10 for i in [3,4]]'
 
####################################################
#	WARNING ABOUT THE USE OF .= AND VIEW
####################################################
 
# correct way to mutate
 
x      = [-1, -2, 1, 2]

slice  = view(x, x .< 0)
slice .= 0
 


# incorrect ways -> no mutation
 
x      = [-1, -2, 1, 2]

slice  = x[x .< 0]          # `slice` now is a new object
slice .= 0                  # this does NOT modify `x`
 


x      = [-1, -2, 1, 2]

slice  = view(x, x .< 0)
slice  = 0                  # this creates a new object, it does not modify `x`
 
############################################################################
#
#           MUTATION VIA FOR-LOOPS
#
############################################################################
 
x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements


for i in eachindex(x)
    x[i] = 0
end
 


y = [3, 4, 5]
x = similar(y)               # `x` replicates the type of `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
    x[i] = 0
end
 


x     = zeros(3)
slice = view(x, 1:2)

for i in eachindex(slice)
    slice[i] = 1
end
 
