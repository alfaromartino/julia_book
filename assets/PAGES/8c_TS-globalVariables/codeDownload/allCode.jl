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
 
const a = 5
foo()   = 2 * a

@code_warntype foo()        # type stable
 


const b = [1, 2, 3]
foo()   = sum(b)

@code_warntype foo()        # type stable
 
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
 
