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
#			GLOBAL VARIABLES
#
############################################################################
 
x = 2

function foo(x) 
    y = 2 * x 
    z = log(y)

    return z
end

@code_warntype foo(x)  # type stable
 



x = 2

function foo() 
    y = 2 * x 
    z = log(y)

    return z
end

@code_warntype foo() # type UNSTABLE
 



# all operations are type UNSTABLE (they're defined in the global scope)
x = 2

y = 2 * x 
z = log(y)
 
############################################################################
#
#                           CONST
#
############################################################################
 
const a = 5
foo()   = 2 * a

@code_warntype foo()        # type stable
 



const b = [1, 2, 3]
foo()   = sum(b)

@code_warntype foo()        # type stable
 
############################################################################
#
#                           PERFORMANCE
#
############################################################################
 
const k1  = 2

function foo()
    for _ in 1:100_000
       2^k1
    end
end
@ctime foo()
 



k2::Int64 = 2

function foo()
    for _ in 1:100_000
       2^k2
    end
end
@ctime foo()
 



k2::Int64 = 2

function foo()
    for _ in 1:1_000_000
       2^k2
    end
end
@ctime foo()
 



# remark on performance
 
Random.seed!(1234)       #setting seed for reproducibility
x           = rand(100_000)


function foo(x)
    y    = similar(x)
    
    for i in eachindex(x,y)
        y[i] = x[i] / sum(x)
    end

    return y
end
@ctime foo($x)
 



Random.seed!(1234)       #setting seed for reproducibility
x           = rand(100_000)


foo(x) = x ./ sum(x)
@ctime foo($x)
 



Random.seed!(1234)       #setting seed for reproducibility
x           = rand(100_000)
const sum_x = sum(x)

foo(x) = x ./ sum_x
@ctime foo($x)
 
