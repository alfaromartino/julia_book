############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
    # uncomment if you don't have the package installed
using FastBenchmark
    

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
############################################################################
#
#			TYPE STABILITY WITH SCALARS AND VECTORS
#
############################################################################
 
############################################################################
#
#           Type Stability with Scalars
#
############################################################################
 
####################################################
#	type promotion and type conversion
####################################################
 
foo(x,y)    = x * y

x1          = 2
y1          = 0.5

output      = foo(x1,y1)      # type stable: mixing `Int64` and `Float64` results in `Float64`
 
println(output)
 



foo(x,y)    = x * y

x2::Float64 = 2               # this is converted to `2.0` 
y2          = 0.5

output      = foo(x2,y2)      # type stable: `x` and `y` are `Float64`, so output type is predictable
 
println(output)
 
####################################################
#	Type Instability
####################################################
 
function foo(x,y)
    a = (x > y) ?  x  :  y

    [a * i for i in 1:100_000]
end

foo(1, 2)           # type stable   -> `a * i` is always `Int64`
@ctime foo(1, 2)
 



function foo(x,y)
    a = (x > y) ?  x  :  y

    [a * i for i in 1:100_000]
end

foo(1, 2.5)         # type UNSTABLE -> `a * i` is either `Int64` or `Float64`
@ctime foo(1, 2.5)
 
############################################################################
#
#           TYPE STABILITY WITH VECTORS
#
############################################################################
 
x = [1, 2, 2.5]      # automatic conversion to `Vector{Float64}`
println(x)
 



y = [1, 2.0, 3.0]    # automatic conversion to `Vector{Float64}`
println(y)
 



v1                 = [1, 2.0, 3.0]     # automatic conversion to `Vector{Float64}`  

w1::Vector{Int64}  = v1                # conversion to `Vector{Int64}`
 
println(w1)
 



v2                 = [1, 2, 2.5]       # automatic conversion to `Vector{Float64}`  

w2::Vector{Number} = v2                # `w2` is still `Vector{Number}`
 
println(w2)
 



####################################################
#	type instability
####################################################
 
z1::Vector{Int}     = [1, 2, 3]

sum(z1)             # type stable
 



z2::Vector{Int64}   = [1, 2, 3]

sum(z2)             # type stable
 



z3::Vector{Float64} = [1, 2, 3]

sum(z3)             # type stable
 



z4::BitVector       = [true, false, true]

sum(z4)             # type stable
 



z                  = [1, 2, 3]

sum(z)             # type stable

@ctime sum(z)
 



z5::Vector{Number} = [1, 2, 3]

sum(z5)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Number`
@ctime sum(z5)
 



z6::Vector{Any}    = [1, 2, 3]

sum(z6)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Any`
@ctime sum(z6)
 
