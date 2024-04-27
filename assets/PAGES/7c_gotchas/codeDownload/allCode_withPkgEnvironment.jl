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
# We use `foo(ref($x))` for more accurate benchmarks of any function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
############################################################################
#
#           GOTCHA 1 : INTEGERS AND FLOATS
#
############################################################################
 
function foo(x)
    y = (x < 0) ?  0  :  x
    
    return [y * i for i in 1:100]
end

#@code_warntype foo(1)      # type stable
@code_warntype foo(1.)     # type unstable
 


function foo(x)
    y = (x < 0) ?  zero(x)  :  x
    
    return [y * i for i in 1:100]
end

#@code_warntype foo(1)      # type stable
@code_warntype foo(1.)     # type stable
 

############################################################################
#
#           GOTCHA 2 : COLLECTIONS OF COLLECTIONS
#
############################################################################
 
vec1 = ["a", "b", "c"] ; vec2 = [1, 2, 3]
data = [vec1, vec2] 

function foo(data) 
    for i in eachindex(data[2])
        data[2][i] = 2 * i
    end
end

@code_warntype foo(data)            # type unstable
#@btime foo(ref($data))
 



vec1 = ["a", "b", "c"] ; vec2 = [1, 2, 3]
data = [vec1, vec2] 

function operation!(x)
    for i in eachindex(x)
        x[i] = 2 * i
    end
end

foo(data) = operation!(data[2])

@code_warntype foo(data)            # type stable
#@btime foo(ref($data))
 

############################################################################
#
#           GOTCHA 3 : BARRIER FUNCTIONS
#
############################################################################
 
vec1 = ["a", "b", "c"] ; vec2 = [1, 2, 3]
data = [vec1, vec2] 

function operation!(x)
    for i in eachindex(x)
        x[i] = 2 * i
    end
end

foo(data) = operation!(data[2])

@code_warntype foo(data)            # type stable
 
#@btime foo(ref($data))
 



vec1 = ["a", "b", "c"] ; vec2 = [1, 2, 3]
data = [vec1, vec2] 

operation(i) = (2 * i)

function foo(data) 
    for i in eachindex(data[2])
        data[2][i] = operation(i)
    end
end

@code_warntype foo(data)            # type unstable
 
#@btime foo(ref($data))
 



vec1 = ["a", "b", "c"] ; vec2 = [1, 2, 3]
data = [vec1, vec2] 

operation!(x,i) = (x[i] = 2 * i)

function foo(data) 
    for i in eachindex(data[2])
        operation!(data[2], i)
    end
end

@code_warntype foo(data)            # type unstable
 
#@btime foo(ref($data))
 

############################################################################
#
#           GOTCHA 4: INFERENCE IS BY TYPE, NOT VALUE
#
############################################################################
 
function foo(condition)
    y = condition ?  2.5  :  1
    
    return [y * i for i in 1:100]
end

@code_warntype foo(true)         # type unstable
@code_warntype foo(false)        # type unstable
 



function foo(::Val{condition}) where condition
    y = condition ?  2.5  :  1
    
    return [y * i for i in 1:100]
end

@code_warntype foo(Val(true))    # type stable
@code_warntype foo(Val(false))   # type stable
 



x = [1,2,3]

function foo(x)                         # 'Vector{Int64}' has no info on the number of elements
    tuple_x = Tuple(x)          

    2 .+ tuple_x
end

@code_warntype foo(x)                   # type unstable
# @btime foo(ref($x))
 



x = [1,2,3]

function foo(x, N)                      # The value of 'N' isn't considered, only its type
    tuple_x = NTuple{N, eltype(x)}(x)   

    2 .+ tuple_x
end

@code_warntype foo(x, length(x))        # type unstable
 



x       = [1,2,3]
tuple_x = Tuple(x)

function foo(x)
    2 .+ x
end

@code_warntype foo(tuple_x)             # type stable
# @btime foo(ref($tuple_x))
 



x = [1,2,3]

function foo(x, ::Val{N}) where N
    tuple_x = NTuple{N, eltype(x)}(x)   

    2 .+ tuple_x    
end

@code_warntype foo(x, Val(length(x)))   # type stable
# @btime foo(ref($tuple_x))
 



x = [1,2,3]

function foo(x)
    tuple_x = Tuple(x)          

    2 .+ tuple_x
end

@code_warntype foo(x)                   # type unstable
# @btime foo(ref($x))
 

############################################################################
#
#           GOTCHA 5: GLOBAL VARIABLES AS DEFAULT VALUES OF KEYWORD ARGUMENTS
#
############################################################################
 
foo(x) = x

x = 1
@code_warntype foo(x)           #type stable
 



foo(; x) = x

β = 1
@code_warntype foo(x=β)         #type stable
 



foo(; x = β) = x

β = 1
@code_warntype foo()            #type unstable
 



foo(; x = α) = x                # or 'x = 1' instead of 'x = α'

const α = 1
@code_warntype foo()            #type stable
 



foo(; x = γ()) = x

γ() = 1
@code_warntype foo()            #type stable
 



foo(; x::Int64 = β) = x

β = 1
@code_warntype foo()            #type stable
 



foo(; x = β::Int64) = x

β = 1
@code_warntype foo()            #type stable
 



x = 2
foo(x; y = 2*x) = x * y

@code_warntype foo(x)            #type stable
 

############################################################################
#
#           GOTCHA 6: CLOSURES CAN EASILY INTRODUCE TYPE INSTABILITIES
#
############################################################################
 
############################################################################
# When the issue arises
############################################################################
 
###################
# first example
####################
 
function foo()
    x            = 1
    bar()        = x
    
    return bar()
end

@code_warntype foo()      # type stable
 



function foo()
    bar(x)       = x
    x            = 1    
    
    return bar(x)
end

@code_warntype foo()      # type stable
 



function foo()
    bar()        = x
    x            = 1
    
    return bar()
end

@code_warntype foo()      # type unstable
 



function foo()
    bar()::Int64 = x::Int64
    x::Int64     = 1       

    return bar()
end

@code_warntype foo()      # type unstable
 



function foo()    
    x = 1
    
    return bar(x)
end

bar(x) = x

@code_warntype foo()      # type stable
 

###################
# second example
####################
 
function foo()
    x            = 1
    x            = 1            # or 'x = x', or 'x = 2'
    
    return x
end

@code_warntype foo()            # type stable
 



function foo()
    x            = 1
    x            = 1            # or 'x = x', or 'x = 2'
    bar(x)       = x
    
    return bar(x)
end

@code_warntype foo()            # type stable
 



function foo()
    x            = 1
    x            = 1            # or 'x = x', or 'x = 2'
    bar()        = x
        
    return bar()
end

@code_warntype foo()            # type unstable
 



function foo()
    x::Int64     = 1
    x            = 1
    bar()::Int64 = x::Int64
    
    return bar()
end

@code_warntype foo()            # type unstable
 



function foo()
    x::Int64     = 1
    bar()::Int64 = x::Int64
    x            = 1
    
    return bar()
end

@code_warntype foo()            # type unstable
 



function foo()
    bar()::Int64 = x::Int64
    x::Int64     = 1
    x            = 1
    
    return bar()
end

@code_warntype foo()            # type unstable
 



function foo()
    x            = 1
    x            = 1            # or 'x = x', or 'x = 2'    
        
    return bar(x)
end

bar(x) = x

@code_warntype foo()            # type stable
 

###################
# third example
####################
 
function foo(x)
    closure1(x) = x
    closure2(x) = closure1(x)
    
    return closure2(x)
end

@code_warntype foo(1)            # type stable
 



function foo(x)
    closure2(x) = closure1(x)
    closure1(x) = x
    
    return closure2(x)
end

@code_warntype foo(1)            # type unstable
 



function foo(x)
    closure2(x, closure1) = closure1(x)
    closure1(x)           = x
    
    return closure2(x, closure1)
end

@code_warntype foo(1)            # type stable
 



function foo(x)
    closure2(x) = closure1(x)    
    
    return closure2(x)
end

closure1(x) = x

@code_warntype foo(1)            # type stable
 

############################################################################
# But No One Writes Code like That
############################################################################
 
################################
# i) Transforming Variables through Conditionals
###################################
 
x = [1,2]; β = 1

function foo(x, β)
    (β < 0) && (β = -β)         # transform 'β' to use its absolute value

    bar(x) = x * β

    return bar(x)
end

@code_warntype foo(x, β)        # type unstable
 



x = [1,2]; β = 1

function foo(x, β)
    (β < 0) && (β = -β)         # transform 'β' to use its absolute value

    bar(x,β) = x * β

    return bar(x,β)
end

@code_warntype foo(x, β)        # type stable
 



x = [1,2]; β = 1

function foo(x, β)
    δ = (β < 0) ? -β : β        # transform 'β' to use its absolute value    

    bar(x) = x * δ

    return bar(x)
end

@code_warntype foo(x, β)        # type stable
 



x = [1,2]; β = 1

function foo(x, β)
    β = abs(β)                  # 'δ = abs(β)' is preferable (you should avoid redefining variables) 

    bar(x) = x * δ

    return bar(x)
end

@code_warntype foo(x, β)        # type stable
 



################################
# ii) Anonymous Functions inside a Function
###################################
 
x = [1,2]; β = 1

function foo(x, β)
    (β < 0) && (β = -β)         # transform 'β' to use its absolute value
    
    filter(x -> x > β, x)       # keep elements greater than 'β'
end

@code_warntype foo(x, β)        # type unstable
 



x = [1,2]; β = 1

function foo(x, β)
    δ = (β < 0) ? -β : β        # define 'δ' as the absolute value of 'β'
    
    filter(x -> x > δ, x)       # keep elements greater than 'δ'
end

@code_warntype foo(x, β)        # type stable
 



x = [1,2]; β = 1

function foo(x, β)
    β = abs(β)                  # 'δ = abs(β)' is preferable (you should avoid redefining variables) 
    
    filter(x -> x > β, x)       # keep elements greater than β
end

@code_warntype foo(x, β)        # type stable
 



################################
# iii) Variable Updates
###################################
 
function foo(x)
    β = 0                      # or 'β::Int64 = 0'
    for i in 1:10
        β = β + i              # equivalent to 'β += i'
    end

    bar() = x + β              # or 'bar(x) = x + β'

    return bar()
end

@code_warntype foo(1)          # type unstable
 



function foo(x)
    β = 0                      # or 'β::Int64 = 0'
    for i in 1:10
        β += i
    end

    bar() = x + β              # or 'bar(x) = x + β'

    return bar()
end

@code_warntype foo(1)          # type unstable
 



function foo(x)
    β = 0
    for i in 1:10
        β = β + i
    end

    bar(x,β) = x + β

    return bar(x,β)
end

@code_warntype foo(1)          # type stable
 



x = [1,2]; β = 1

function foo(x, β)
    (1 < 0) && (β = β)

    bar(x) = x * β

    return bar(x)
end

@code_warntype foo(x, β)        # type unstable
 



################################
# iv) The Order in Which you Define Functions Could Matter Inside a Function
###################################
 
function foo(β)
    x(β)                  =  2 * rescale_parameter(β)
    rescale_parameter(β)  =  β / 10

    return x(β)
end

@code_warntype foo(1)      # type unstable
 



function foo(β)
    rescale_parameter(β)  =  β / 10
    x(β)                  =  2 * rescale_parameter(β)  
    
    return x(β)
end

@code_warntype foo(1)      # type stable
 
