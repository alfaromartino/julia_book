############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# for more accurate results, we perform benchmarks through functions and interpolate each variable.
# this means that benchmarking a function `foo(x)` should be `foo($x)`
using BenchmarkTools
 
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
#@btime foo(abs, $x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    f(1)                # irrelevant computation to force specialization

    sum(y)
end
#@btime foo(abs, $x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)


function foo(f, x)
    y = map(f, x)
    f(1)                # irrelevant computation to force specialization

    sum(y)
end
#@btime foo(abs, $x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)


function foo(f::F, x) where F
    y = map(f, x)
    

    sum(y)
end
#@btime foo(abs, $x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    y = map(f_tup[1], x)
    

    sum(y)
end
#@btime foo($f_tup, $x)
 
############################################################################
#
#      SEVERITY OF THE NO-SPECIALIZATION ISSUE
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)

    
    for i in 1:100_000
        sum(y) + i
    end
end
#@btime foo(abs, $x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f)
    y = map(f, x)

    
    for i in 1:100_000
        sum(y) + i
    end
end

#@btime foo(abs)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    f(1)                            # irrelevant computation to force specialization

    for i in 1:100_000
        sum(y) + i
    end
end
#@btime foo(abs, $x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y      = map(f[1], x)


    for i in 1:100_000
        sum(y) + i
    end
end
tup = (abs,)
#@btime foo($tup, $x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f::F, x) where F
    y = map(f, x)
    
    
    for i in 1:100_000
        sum(y) + i
    end

end
#@btime foo(abs, $x)
 
############################################################################
#
#      COLLECTION OF FUNCTIONS
#
############################################################################
 
a    = 1
funs = [log, exp]

function foo(funs, a)
    y = map(fun -> map(fun, a), funs)

    for _ in 1:1_000
        sum(y)
    end
end
#@btime foo($funs, $a)
 



a    = 1
funs = [log, exp]

function foo(funs, a)
    y = [fun(a) for fun in funs]

    for _ in 1:1_000
        sum(y)
    end
end
#@btime foo($funs, $a)
 



a    = 1
funs = [log, exp]

function foo(funs)
    y = [fun(a) for fun in funs]

    for _ in 1:1_000
        sum(y)
    end
end

#@btime foo($funs)
 



a    = 1
funs = (log, exp)

function foo(funs, a)
    y = [fun(a) for fun in funs]

    for _ in 1:1_000
        sum(y)
    end
end

#@btime foo($funs, $a)
 
############################################################################
#
#      NO SPECIALIZATION ON TYPES
#
############################################################################
 
function foo(type)
    size = 100
    x    = ones(type, size)
    
    sum(x)
end

#@btime foo(Int64)
 



function foo(t::Type{T}) where T
    size = 100
    x    = ones(T, size)
    
    sum(x)
end

#@btime foo(Int64)
 
############################################################################
#
#      NO SPECIALIZATION ON VARIABLE ARGUMENTS (VARARG)
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(10)

function foo1(x)
    max(x...)
end
#@btime foo1($x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(10)

function foo2(x::Vararg{T,N}) where {T,N}
    max(x...)
end
#@btime foo2($x...)
 
