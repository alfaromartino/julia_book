####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used when writing this note.
# It requires having all files (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml) in the same folder.

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate benchmarks, we interpolate variable `x` as in `foo($x)`
using BenchmarkTools



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
 
tup    = (1, 2, 3.5)                    # type is `Tuple{Int64, Int64, Float64}`

foo(x) = sum(x[1:2])

@code_warntype foo(tup)                 # type stable (output returned is `Int64`)
 


vector = [1, 2, 3.5]                    # type is `Vector{Float64}` (type promotion)

foo(x) = sum(x[1:2])

@code_warntype foo(vector)              # type stable (output returned is `Float64`)
 



tup    = (1, 2, "hello")                # type is `Tuple{Int64, Int64, String}`

foo(x) = sum(x[1:2])

@code_warntype foo(tup)                 # type stable (output is `Int64`)
 


vector = [1, 2, "hello"]                # type is `Vector{Any}`

foo(x) = sum(x[1:2])

@code_warntype foo(vector)              # type UNSTABLE
 



#	The same conclusions hold for Named Tuples
 
nt     = (a = 1, b = 2, c = 3.5)        # `nt` has type @NamedTuple{a::Int64, b::Int64, c::Float64}

foo(x) = sum(x.a + x.b)

@code_warntype foo(nt)                  # type stable (output is `Int64`)
 


nt     = (a = 1, b = 2, c = "hello")    # `nt` has type @NamedTuple{a::Int64, b::Int64, c::String}

foo(x) = sum(x.a + x.b)

@code_warntype foo(nt)                  # type stable (output is `Int64`)
 
############################################################################
#  VECTORS CONTAIN LESS INFORMATION THAN TUPLES
############################################################################
 
# from tuple to vectors
 
tup = (1, 2, "hello")         # `Tuple{Int64, Int64, String}`


function foo(tup)
    x = Vector(tup)           # 'x' has type `Vector(Any)}`

    sum(x)
end

@code_warntype foo(tup)       # type UNSTABLE
 



tup = (1, 2, 3)               # `Tuple{Int64, Int64, Int64}` or just `NTuple{3, Int64}`


function foo(tup)
    x = Vector(tup)           # 'x' has type `Vector(Int64)}`

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
 



x   = [1, 2, 3]
tup = Tuple(x)

foo(tup) = sum(tup[1:2])

@code_warntype foo(tup)         # type stable
 
############################################################################
#  INFERENCE IS BY TYPE, NOT VALUE
############################################################################
 
# remark
 
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
 



# DISPATCHING BY VALUE
 
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
 



x = [1, 2, 3]

function foo(x, N)
    tuple_x = NTuple{N, eltype(x)}(x)   

    2 .+ tuple_x    
end

@code_warntype foo(x, length(x))        # type UNSTABLE
#@btime foo($tuple_x)
 


x = [1, 2, 3]

function foo(x, ::Val{N}) where N
    tuple_x = NTuple{N, eltype(x)}(x)   

    2 .+ tuple_x    
end

@code_warntype foo(x, Val(length(x)))   # type stable
#@btime foo($tuple_x)
 
