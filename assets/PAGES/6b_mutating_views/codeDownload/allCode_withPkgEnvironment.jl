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
#           MUTATION THROUGH VECTORS
#
############################################################################
 

x         = [1, 2, 3, 4]

x[3]      = 30
x[4]      = 40
 

x         = [1, 2, 3, 4]


x[3:end]  = [30, 40]
 

x         = [1, 2, 3, 4]


x[3:end]  = [x[i] * 10 for i in 3:length(x)]
 

x         = [1, 2, 3, 4]


x[x .≥ 3] = [x[i] * 10 for i in 3:length(x)]
 

x         = [1, 2, 3, 4]


x[x .≥ 3] = x[x .≥ 3] .* 10
 

x    = [1, 2, 3, 4]

x    = x .* 10
 

x    = [1, 2, 3, 4]

x[:] = x .* 10
 

############################################################################
#
#           MUTATION THROUGH .=
#
############################################################################
 

x          = [-1, -2, 3, 4]

x[x .< 0]  = zeros(length(x[x .< 0]))
 

x          = [-1, -2, 3, 4]

x[x .< 0] .= zeros(length(x[x .< 0]))           # identical output
 

x          = [-1, -2, 3, 4]

x[x .< 0] .= 0
 

x          = [-1, -2, 3, 4]

x[x .< 0] .= zeros(length(x[x .< 0]))
 

x          = [1, 2, 3, 4]

condition  = (x .≥ 1) .&& (x .≤ 2)
slice      = view(x, condition)

slice     .= slice .* 10
 

###############
# an explicit view
###############
 

x      = [1, 2, 3, 4]
slice  = view(x, x .≥ 3)

slice .= x[x .≥ 3] .* 10                 # same operation as 'x[x .≥ 3] = x[x .≥ 3] .* 10'
 

x      = [1, 2, 3, 4]
slice  = view(x, x .≥ 3)

slice .= [i * 10 for i in [3,4]]     # same operation as 'x[x .≥ 3] = [i * 10 for i in [3,4]]'
 

x          = [1, 2, 3, 4]
x[x .≥ 3] .= x[x .≥ 3] .* 10
 

x          = [1, 2, 3, 4]
x[x .≥ 3]  = x[x .≥ 3] .* 10
 

x          = [-1, -2, 1, 2]

x[x .< 0] .= 0
 

############################################################################
#
# SORTPERM -> indices of the sorted vector
#
############################################################################
 

x  = [-1, -2, 1, 2]

y  = view(x, x .< 0)
y .= 0
 

x  = [-1, -2, 1, 2]

y  = x[x .< 0]              # `y` is a new object
y .= 0                      # this does NOT modify `x`
 

x  = [1, 2, 3, 4]

y  = view(x, x .≥ 3)
y .= x[x .≥ 3] .* 10
 

x  = [1, 2, 3, 4]

y  = view(x, x .≥ 3)
y  = x[x .≥ 3] .* 10    # this creates a new variable 'y'
 

x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements


for i in eachindex(x)
    x[i] = i
end
 

y = [3, 4, 5]
x = similar(y)            # `x` mimicks the type of `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
    x[i] = i
end
 

x = zeros(Int64,3)         # `x` is Vector{Int64} with 3 elements equal to zero


for i in eachindex(x)
    x[i] = i
end
 
x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined Int64 elements


for i in eachindex(x)
#    x[i] = i * 2.5                
end
 
y = [3, 4, 5]
x = similar(y)            # `x` has the same type as `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
#    x[i] = i * 2.5
end
 
x = zeros(Int64,3)         # `x` is Vector{Int64} with 3 elements equal to zero


for i in eachindex(x)
#    x[i] = i * 2.5 
end
 
