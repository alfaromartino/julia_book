############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
############################################################################
#
#           TYPE STABILITY WITH TUPLES
#
############################################################################
 
############################################################################
#  COMPARING TUPLES AND VECTORS
############################################################################
 
# Tuple Slices with Mixed Types Can Still Be Type Stable
 
tup    = (1, 2, "hello")        # type is `Tuple{Int64, Int64, String}`

foo(x) = sum(x[1:2])

@code_warntype foo(tup)         # type stable (output is `Int64`)
 



vector = [1, 2, "hello"]        # type is `Vector{Any}`

foo(x) = sum(x[1:2])

@code_warntype foo(vector)      # type UNSTABLE
 



# Tuples Contain More Information than Vectors
 
tup = (1, 2, 3.5)             # `Tuple{Int64, Int64, Float64}`


function foo(tup)
    x = Vector(tup)           # 'x' has type `Vector(Float64)}`
    sum(x)
end

@code_warntype foo(tup)       # type stable
 



tup = (1, 2, 3)               # `Tuple{Int64, Int64, Int64}` or just `NTuple{3, Int64}`


function foo(tup)
    x = Vector(tup)           # 'x' has type `Vector(Int64)}`
    sum(x)
end

@code_warntype foo(tup)       # type stable
 



tup = (1, 2, "hello")         # `Tuple{Int64, Int64, String}`


function foo(tup)
    x = Vector(tup)           # 'x' has type `Vector(Any)}`
    sum(x)
end

@code_warntype foo(tup)       # type UNSTABLE
 



# from vector to tuples
 
x   = [1, 2, "hello"]           # 'Vector{Any}' has no info on each individual type


function foo(x)
    tup = Tuple(x)              # 'tup' has type `Tuple`

    sum(tup[1:2])
end

@code_warntype foo(x)           # type UNSTABLE
 



x   = [1, 2, 3]                 # 'Vector{Int64}' has no info on the number of elements


function foo(x)
    tup = Tuple(x)              # 'tup' has type `Tuple{Vararg(Int64)}` (`Vararg` means "variable arguments")

    sum(tup[1:2])
end

@code_warntype foo(x)           # type UNSTABLE
 



############################################################################
#
#			ADDRESSING VARIABLE ARGUMENTS: DISPATCH BY VALUE
#
############################################################################
 
x   = [1, 2, 3]
tup = Tuple(x)

foo(tup) = sum(tup[1:2])

@code_warntype foo(tup)         # type stable
 



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
 



# Defining Dispatch By Value
 
function foo(condition)
    y = condition ? 1 : 0.5      # either `Int64` or `Float64`
    
    [y * i for i in 1:100]
end

@code_warntype foo(true)         # type UNSTABLE
@code_warntype foo(false)        # type UNSTABLE
 



function foo(::Val{condition}) where condition
    y = condition ? 1 : 0.5      # either `Int64` or `Float64`
    
    [y * i for i in 1:100]
end

@code_warntype foo(Val(true))    # type stable
@code_warntype foo(Val(false))   # type stable
 



# Dispatching by Value with Tuples
 
x = [1, 2, 3]

function foo(x, N)
    tuple_x = NTuple{N, eltype(x)}(x)   

    2 .+ tuple_x    
end

@code_warntype foo(x, length(x))        # type UNSTABLE
 



x = [1, 2, 3]

function foo(x, ::Val{N}) where N
    tuple_x = NTuple{N, eltype(x)}(x)   

    2 .+ tuple_x    
end

@code_warntype foo(x, Val(length(x)))   # type stable
 
