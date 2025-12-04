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
 
# necessary packages for this file
using Random
 
############################################################################
#
#      NO SPECIALIZATION ON FUNCTIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    
    sum(y)    
end
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    

    sum(y)    
end
@btime foo(abs, $x)
 







Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    f(1)                # irrelevant computation to force specialization

    sum(y)
end
@btime foo(abs, $x)
 



############################################################################
#
#			SOLUTIONS
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)


function foo(f::F, x) where F
    y = map(f, x)
    

    sum(y)
end
@btime foo(abs, $x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    y = map(f_tup[1], x)
    

    sum(y)
end
@btime foo($f_tup, $x)
 
