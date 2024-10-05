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
 
############################################################################
#
#           MUTATIONS VIA VECTORS
#
############################################################################
 
x         = [1, 2, 3]

x[3]      = 30
 


x         = [1, 2, 3]

x[2:end]  = [20, 30]
 


x         = [1, 2, 3]

x[x .≥ 2] = [2, 3] .* 10
 


x         = [1, 2, 3]

x[x .≥ 2] = x[x .≥ 2] .* 10
 


x         = [1, 2, 3]

x[2:end]  = [x[i] * 10 for i in 2:length(x)]
 


####################################################
#	WARNING: MUTATION VS ASSIGNMENT
####################################################
 
# assignment
 
x    = [1, 2, 3]

x    = x .* 10
 


# mutation
 
x    = [1, 2, 3]

x[:] = x .* 10
 


############################################################################
#
#           MUTATION VIA .=
#
############################################################################
 


x          = [-2, -1, 1]

x[x .< 0] .= 0
 


x          = [-2, -1, 1]

x[x .< 0] .= zeros(length(x[x .< 0]))           # identical output
 


x          = [-2, -1, 1]

x[x .< 0]  = zeros(length(x[x .< 0]))
 


############################################################################
#
#           COMBINING .= and view
#
############################################################################
 
x          = [-2, -1, 1]


x[x .< 0] .= 0
 


x          = [-2, -1, 1]

slice      = view(x, x .< 0)            # or slice = @view x[x .< 0]
slice     .= 0
 


####################################################
#	same operations allowed
####################################################
 
x      = [1, 2, 3]
slice  = view(x, x .≥ 2)

slice .= slice .* 10                                  # same as 'x[x .≥ 2] = x[x .≥ 2] .* 10'
 


x      = [1, 2, 3]
slice  = view(x, x .≥ 2)

slice .= [slice[i] * 10 for i in eachindex(slice)]    # same as 'x[x .≥ 2] = [x[i] * 10 for i in eachindex(x[x .≥ 2])]'
 
####################################################
#	WARNING ABOUT THE USE OF .= AND VIEW
####################################################
 
# correct way to mutate
 
x      = [-2, -1, 1]

slice  = view(x, x .< 0)
slice .= 0
 


# incorrect ways -> no mutation
 
x      = [-2, -1, 1]

slice  = x[x .< 0]          # `slice` is a copy
slice .= 0                  # this does NOT modify `x`
 


x      = [-2, -1, 1]

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
 


y = [1, 2, 3]
x = similar(y)               # `x` replicates the type of `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
    x[i] = 0
end
 


x     = zeros(3)
slice = view(x, 1:2)

for i in eachindex(slice)
    slice[i] = 1
end
 
