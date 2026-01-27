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
 
# necessary packages for this file
using Random
 
############################################################################
#
#			TYPE STABILITY WITH HIGHER-ORDER FUNCTOINS
#
############################################################################
 
############################################################################
#
#			AN EXAMPLE OF NO SPECIALIZATION
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x         = rand(100)

foo(f, x) = f.(x)
@code_warntype foo(abs, x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(f, x)
    
    f.(x)
end
 
@ctime foo(abs, $x)
 
println(foo(abs, x))
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(f, x)
    f(1)                # irrelevant computation to force specialization
    f.(x)
end
 
@ctime foo(abs, $x)
 
println(foo(abs, x))
 



############################################################################
#
#			FORCING SPECIALIZATION
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x     = rand(100)

function foo(f, x)
    
    f.(x)
end
 
@ctime foo(abs, $x)
 
println(foo(abs, x))
 



Random.seed!(123)       #setting seed for reproducibility
x     = rand(100)


function foo(f::F, x) where F
    f.(x)
end
 
@ctime foo(abs, $x)
 
println(foo(abs, x))
 



Random.seed!(123)       #setting seed for reproducibility
x     = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    f_tup[1].(x)    
end
 
@ctime foo($f_tup, $x)
 
println(foo(f_tup, x))
 
