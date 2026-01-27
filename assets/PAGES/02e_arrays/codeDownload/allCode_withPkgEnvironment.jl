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
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
############################################################################
#
#			SECTION: "VECTORS"
#
############################################################################
 
x = [1, 2, 3]          #= column-vector (defined using commas or semicolons)
                           Vector{Int64} (alias for Array{Int64, 1}) =# 

x = [1; 2; 3]          # equivalent
println(x)
 



x = [4, 5, 6]
 
println(x)
 
println(x[2])
 
println(x[:])
 



x = [4, 5, 6, 7, 8]
 
println(x)
 
println(x[[1,3]])
 
#println(x[1,3]) #ERROR
 



x = [4, 5, 6, 7, 8]
 
println(x)
 
println(x[1:2])
 
println(x[1:2:5])
 
println(x[begin:end])
 
############################################################################
#
#			MATRICES (optional)
#
############################################################################
 
X = [1 2 ; 3 4]       #= matrix as a collection of row-vectors, separated by semicolons
                         Matrix{Int64} (alias for Array{Int64, 2})=#

X = [ [1,3] [2,4] ]   # identical to `X`, but defined through a collection of column-vectors

Y = [1 2 3]           #= row-vector (defined without commas)
                         Matrix{Int64} (alias for Array{Int64, 2}) =#
 
println(X)
 
println(Y)
 



X = [5 6 ; 7 8] # matrix

Y = [4 5 6]     # row-vector
 
println(X)
 
println(X[2,1])
 
println(X[1,:])
 
println(X[:,2])
 
println(Y[2])
 



X = [5 6 ; 7 8]
 
println(X)
 
println(X[[1,2],1])
 
println(X[1:2,1])
 
println(X[begin:end,1])
 
