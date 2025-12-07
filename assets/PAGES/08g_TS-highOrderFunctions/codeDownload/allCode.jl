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
#      NO SPECIALIZATION ON FUNCTIONS
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
#			SOLUTIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100)


function foo(f::F, x) where F
    f.(x)
end
@ctime foo(abs, $x)
 
println(foo(abs, x))
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    f_tup[1].(x)    
end
@ctime foo($f_tup, $x)
 
println(foo(f_tup, x))
 
