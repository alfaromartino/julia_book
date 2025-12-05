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

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git") #uncomment if you don't have the package installed
using FastBenchmark
    
############################################################################
#   AUXILIARS FOR DISPLAYING RESULTS
############################################################################
# you can alternatively use "println" or "display"
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x)


############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Random
 
############################################################################
#
#      NO SPECIALIZATION ON FUNCTIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    
    sum(y)    
end
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    

    sum(y)    
end
@ctime foo(abs, $x)
 







Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    f(1)                # irrelevant computation to force specialization

    sum(y)
end
@ctime foo(abs, $x)
 



############################################################################
#
#			SOLUTIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100)


function foo(f::F, x) where F
    y = map(f, x)
    

    sum(y)
end
@ctime foo(abs, $x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    y = map(f_tup[1], x)
    

    sum(y)
end
@ctime foo($f_tup, $x)
 
