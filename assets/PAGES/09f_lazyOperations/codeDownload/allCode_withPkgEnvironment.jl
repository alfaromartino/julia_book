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
#			LAZY OPERATIONS
#
############################################################################
 
############################################################################
#
#			GENERATORS
#
############################################################################
 
x = [a for a in 1:10]

y = [a for a in 1:10 if a > 5]

println(x)
 
println(y)
 



x = (a for a in 1:10)

y = (a for a in 1:10 if a > 5)

println(x)
 
println(y)
 



####################################################
#	example: generators in reductions
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(x)
    y = [a * 2 for a in x]       # 1 allocation
    
    sum(y)
end
    
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(x)
    y = (a * 2 for a in x)      # 0 allocations
    
    sum(y)
end
    
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)


foo(x) = sum(a * 2 for a in x)  # 0 allocations
    
@ctime foo($x)
 



############################################################################
#
#			ITERATORS
#
############################################################################
 
x = 1:10
 
println(x)
 



x = collect(1:10)
 
println(x)
 



####################################################
#	PACKAGE ITERATORS
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = collect(1:100)

function foo(x)
    y = filter(a -> a > 50, x)              # 1 allocation 

    sum(y)
end
    
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = collect(1:100)

function foo(x)
    y = Iterators.filter(a -> a > 50, x)    # 0 allocations 

    sum(y)
end
    
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(x) 
    y = map(a -> a * 2, x)                  # 1 allocation

    sum(y)
end
    
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100)

function foo(x)
    y = Iterators.map(a -> a * 2, x)        # 0 allocations

    sum(y)
end
    
@ctime foo($x)
 
