############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# We use `foo(ref($x))` for more accurate benchmarks of any function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
# necessary packages for this file
using Chairmarks, BenchmarkTools
 
############################################################################
#
#           TYPE STABILITY WITH TUPLES
#
############################################################################
 
############################################################################
#  TUPLES ALLOWS HETEROGENEOUS TYPES OF ELEMENTS
############################################################################
 
tup    = (1, 2.5, 3)                    # `tup` has type `Tuple{Int64, Int64, Int64}` or just `NTuple{3, Int64}`

foo(x) = sum(x[1:2])

@code_warntype foo(tup)                 # type stable (type promotion of `Int64` and `Float64` to `Float64`)
 



tup    = (1, 2.5, "hello")              # `tup` has type `Tuple{Int64, Float64, String}`

foo(x) = sum(x[1:2])

@code_warntype foo(tup)                 # type stable
 



nt     = (a = 1, b = 2.5, c = "hello")  # `nt` has type @NamedTuple{a::Int64, b::Float64, c::String}

foo(x) = sum(x.a + x.b)

@code_warntype foo(nt)                  # type stable
 
############################################################################
#  VECTORS CONTAIN LESS INFORMATION THAN TUPLES
############################################################################
 
tup = (1,2,3)                 # `Tuple{Int64, Int64, Int64}`, or just `NTuple{3, Int64}`


function foo(tup)
    x = Vector(tup)           # 'x' has type `Vector(Int64)}`

    sum(x)
end

@code_warntype foo(tup)       # type stable
 



x   = [1, 2, 3]                 # 'Vector{Int64}' has no info on the number of elements


function foo(x)
    tup = Tuple(x)            # 'tup' has type `Tuple{Vararg(Int64)}`

    sum(tup)
end

@code_warntype foo(x)         # type UNSTABLE
 



x   = [1, 2, 3]                 # 'Vector{Int64}' has no info on the number of elements
tup = Tuple(x)

function foo(tup)
    

    sum(tup)
end

@code_warntype foo(tup)       # type stable
 



x   = [1, 2, 3]


function foo(x)
    tup = NTuple{length(x), eltype(x)}(x)

    sum(tup)
end

@code_warntype foo(x)        # type UNSTABLE
 



x   = [1, 2, 3]


function foo(x)
    tup = NTuple{3, eltype(x)}(x)

    sum(tup)
end

@code_warntype foo(tup)       # type stable
 
############################################################################
#  INFERENCE IS BY TYPE, NOT VALUE
############################################################################
 
function foo(condition)
    y = condition ?  2.5  :  1
    
    return [y * i for i in 1:100]
end

@code_warntype foo(true)         # type UNSTABLE
@code_warntype foo(false)        # type UNSTABLE
 



function foo(::Val{condition}) where condition
    y = condition ?  2.5  :  1
    
    return [y * i for i in 1:100]
end

@code_warntype foo(Val(true))    # type stable
@code_warntype foo(Val(false))   # type stable
 



x       = [1, 2, 3]


function foo(x)                         # 'Vector{Int64}' has no info on the number of elements
    tuple_x = Tuple(x)          

    2 .+ tuple_x
end

@code_warntype foo(x)                   # type UNSTABLE
@btime foo(ref($x))
 



x       = [1, 2, 3]


function foo(x, N)                      # The value of 'N' isn't considered, only its type (which is just Int64)
    tuple_x = NTuple{N, eltype(x)}(x)   

    2 .+ tuple_x
end

@code_warntype foo(x, length(x))        # type UNSTABLE
 



x       = [1, 2, 3]
tuple_x = Tuple(x)

function foo(x)


    2 .+ x
end

@code_warntype foo(tuple_x)             # type stable
@btime foo(ref($tuple_x))
 



x = [1, 2, 3]

function foo(x, ::Val{N}) where N
    tuple_x = NTuple{N, eltype(x)}(x)   

    2 .+ tuple_x    
end

@code_warntype foo(x, Val(length(x)))   # type stable
@btime foo(ref($tuple_x))
 



x = [1, 2, 3]

function foo(x)
    tuple_x = Tuple(x)          

    2 .+ tuple_x
end

@code_warntype foo(x)                   # type UNSTABLE
@btime foo(ref($x))
 

############################################################################
#
#      NO SPECIALIZATION ON FUNCTIONS
#
############################################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    

    sum(y)    
end
@btime foo(ref(abs), ref($x))
 



using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    f(1)                # irrelevant computation to force specialization

    sum(y)
end
@btime foo(ref(abs), ref($x))
 



using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)


function foo(f, x)
    y = map(f, x)
    f(1)                # irrelevant computation to force specialization

    sum(y)
end
@btime foo(ref(abs), ref($x))
 



using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)


function foo(f::F, x) where F
    y = map(f, x)
    

    sum(y)
end
@btime foo(ref(abs), ref($x))
 



using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)
f_tup = (abs,)

function foo(f_tup, x)
    y = map(f_tup[1], x)
    

    sum(y)
end
@btime foo(ref($f_tup), ref($x))
 
############################################################################
#
#      SEVERITY OF THE NO-SPECIALIZATION ISSUE
#
############################################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)

    
    for i in 1:100_000
        sum(y) + i
    end
end
@btime foo(ref(abs), ref($x))
 



using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f)
    y = map(f, x)

    
    for i in 1:100_000
        sum(y) + i
    end
end

@btime foo(ref(abs))
 



using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y = map(f, x)
    f(1)                            # irrelevant computation to force specialization

    for i in 1:100_000
        sum(y) + i
    end
end
@btime foo(ref(abs), ref($x))
 



using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f, x)
    y      = map(f[1], x)


    for i in 1:100_000
        sum(y) + i
    end
end
tup = (abs,)
@btime foo(ref($tup), ref($x))
 



using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(f::F, x) where F
    y = map(f, x)
    
    
    for i in 1:100_000
        sum(y) + i
    end

end
@btime foo(ref(abs), ref($x))
 
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
@btime foo(ref($funs), ref($a))
 



a    = 1
funs = [log, exp]

function foo(funs, a)
    y = [fun(a) for fun in funs]

    for _ in 1:1_000
        sum(y)
    end
end
@btime foo(ref($funs), ref($a))
 



a    = 1
funs = [log, exp]

function foo(funs)
    y = [fun(a) for fun in funs]

    for _ in 1:1_000
        sum(y)
    end
end

@btime foo(ref($funs))
 



a    = 1
funs = (log, exp)

function foo(funs, a)
    y = [fun(a) for fun in funs]

    for _ in 1:1_000
        sum(y)
    end
end

@btime foo(ref($funs), ref($a))
 
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

@btime foo(Int64)
 



function foo(t::Type{T}) where T
    size = 100
    x    = ones(T, size)
    
    sum(x)
end

@btime foo(Int64)
 
############################################################################
#
#      NO SPECIALIZATION ON VARIABLE ARGUMENTS (VARARG)
#
############################################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(10)

function foo1(x)
    max(x...)
end
@btime foo1($x)
 



using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(10)

function foo2(x::Vararg{T,N}) where {T,N}
    max(x...)
end
@btime foo2($x...)
 
