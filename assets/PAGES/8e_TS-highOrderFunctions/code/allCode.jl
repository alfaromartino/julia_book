include(joinpath(homedir(), "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Chairmarks, BenchmarkTools
 
############################################################################
#
#      NO SPECIALIZATION ON FUNCTIONS
#
############################################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y = map(f, x)
    

    sum(y)    
end
#@btime foo(ref(abs), $x) #hide
 
print_compact(foo(abs, x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y = map(f, x)
    f(1)                # irrelevant computation to force specialization

    sum(y)
end
#@btime foo(ref(abs), $x) #hide
 
print_compact(foo(abs, x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)


function foo(f, x)
    y = map(f, x)
    f(1)                # irrelevant computation to force specialization

    sum(y)
end
#@btime foo(ref(abs), $x) #hide
 
print_compact(foo(abs, x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)


function foo(f::F, x) where F
    y = map(f, x)
    

    sum(y)
end
#@btime foo(ref(abs), $x) #hide
 
print_compact(foo(abs, x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    y = map(f_tup[1], x)
    

    sum(y)
end
#@btime foo($f_tup, $x) #hide
 
print_compact(foo(f_tup, x))
 
############################################################################
#
#      SEVERITY OF THE NO-SPECIALIZATION ISSUE
#
############################################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y = map(f, x)

    
    for i in 1:100_000
        sum(y) + i
    end
end
#@btime foo(ref(abs), $x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f)
    y = map(f, x)

    
    for i in 1:100_000
        sum(y) + i
    end
end

#@btime foo(ref(abs)) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y = map(f, x)
    f(1)                            # irrelevant computation to force specialization

    for i in 1:100_000
        sum(y) + i
    end
end
#@btime foo(ref(abs), $x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f, x)
    y      = map(f[1], x)


    for i in 1:100_000
        sum(y) + i
    end
end
tup = (abs,)
#@btime foo($tup, $x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(f::F, x) where F
    y = map(f, x)
    
    
    for i in 1:100_000
        sum(y) + i
    end

end
#@btime foo(ref(abs), $x) #hide
 
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
#@btime foo($funs, $a) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a    = 1
funs = [log, exp]

function foo(funs, a)
    y = [fun(a) for fun in funs]

    for _ in 1:1_000
        sum(y)
    end
end
#@btime foo($funs, $a) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a    = 1
funs = [log, exp]

function foo(funs)
    y = [fun(a) for fun in funs]

    for _ in 1:1_000
        sum(y)
    end
end

#@btime foo($funs) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a    = 1
funs = (log, exp)

function foo(funs, a)
    y = [fun(a) for fun in funs]

    for _ in 1:1_000
        sum(y)
    end
end

#@btime foo($funs, $a) #hide
 
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

#@btime foo(Int64) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo(t::Type{T}) where T
    size = 100
    x    = ones(T, size)
    
    sum(x)
end

#@btime foo(Int64) #hide
 
############################################################################
#
#      NO SPECIALIZATION ON VARIABLE ARGUMENTS (VARARG)
#
############################################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10)

function foo1(x)
    max(x...)
end
#@btime foo1($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10)

function foo2(x::Vararg{T,N}) where {T,N}
    max(x...)
end
#@btime foo2($x...) #hide
 
