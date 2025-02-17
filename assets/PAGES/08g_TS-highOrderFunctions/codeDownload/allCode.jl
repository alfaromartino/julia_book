############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate results, we benchmark code through functions and interpolate each argument.
    # this means that benchmarking a function `foo(x)` makes use of `foo($x)`
using BenchmarkTools

# The following defines the macro `@fast_btime foo($x)`
    # `@fast_btime` is equivalent to `@btime` but substantially faster
    # if you want to use it, you should replace `@btime` with `@fast_btime`
    # by default, if `@fast_btime` doesn't provide allocations, it means there are none
using Chairmarks
macro fast_btime(ex)
    return quote
        display(@b $ex)
    end
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
 
