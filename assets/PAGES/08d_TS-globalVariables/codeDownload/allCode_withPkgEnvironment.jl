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
# For more accurate results, we benchmark code through functions.
    # We also interpolate each function argument, so that they're taken as local variables.
    # All this means that benchmarking a function `foo(x)` is done via `foo($x)`
using BenchmarkTools

# The following defines the macro `@ctime`, which is equivalent to `@btime` but faster
    # to use it, replace `@btime` with `@ctime`
using Chairmarks
macro ctime(expr)
    esc(quote
        object = @b $expr
        result = sprint(show, "text/plain", object) |>
            x -> object.allocs == 0 ?
                x * " (0 allocations: 0 bytes)" :
                replace(x, "allocs" => "allocations") |>
            x -> replace(x, r",.*$" => ")") |>
            x -> replace(x, "(without a warmup) " => "")
        println("  " * result)
    end)
end

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
############################################################################
#
#                           GLOBAL VARIABLES
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

@btime foo()    # hide
 


k2::Int64 = 2

function foo()
    for _ in 1:100_000
       2^k2
    end
end

@btime foo()    # hide
 


k2::Int64 = 2

function foo()
    for _ in 1:1_000_000
       2^k2
    end
end

@btime foo()    # hide
 


# remark on performance
 
using Random; Random.seed!(1234) # hide
x           = rand(100_000)


function foo(x)
    y    = similar(x)
    
    for i in eachindex(x,y)
        y[i] = x[i] / sum(x)
    end

    return y
end
@btime foo($x)    # hide
 


using Random; Random.seed!(1234) # hide
x           = rand(100_000)


foo(x) = x ./ sum(x)

@btime foo($x)    # hide
 


using Random; Random.seed!(1234) # hide
x           = rand(100_000)
const sum_x = sum(x)

foo(x) = x ./ sum_x

@btime foo($x)    # hide
 
