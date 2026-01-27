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
#           IN-PLACE FUNCTIONS
#
############################################################################
 
y = [0,0]

function foo(x)
    x[1] = 1
end
 
println(y)
 
println(foo(y))
 
println(y)
 
####################################################
#	Functions Can't Reassign Variables
####################################################
 
x = 2

function foo(x)
    x = 3
end
 
println(x)
 
println(foo(x))
 
println(x)
 



x = [1,2]

function foo()
    x = [0,0]
end
 
println(x)
 
println(foo(x))
 
println(x)
 
############################################################################
#
#			BUILT-IN IN-PLACE FUNCTIONS
#
############################################################################
 
####################################################
#	single-argument function
####################################################
 
x      = [2, 1, 3]

output = sort(x)
 
println(x)
 
println(output)
 



x      = [2, 1, 3]

sort!(x)
 
println(x)
 
####################################################
#	multiple-argument Functions
####################################################
 
x      = [1, 2, 3]


output = map(a -> a^2, x)
 
println(x)
 
println(output)
 



x      = [1, 2, 3]
output = similar(x)             # we initialize `output`

map!(a -> a^2, output, x)       # we update `output`
 
println(x)
 
println(output)
 
############################################################################
#
#			MUTATIONS VIA FOR-LOOPS
#
############################################################################
 
x = [3,4,5]

function foo!(x)
    for i in 1:2
        x[i] = 0
    end
end
 
println(foo!(x))
 
println(x)
 



x = Vector{Int64}(undef, 3)           # initialize a vector with 3 elements

function foo!(x)
    for i in eachindex(x)
        x[i] = 0
    end
end
 
println(foo!(x))
 
println(x)
 
