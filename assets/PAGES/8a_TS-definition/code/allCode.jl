include(joinpath(homedir(), "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Statistics, BenchmarkTools, Chairmarks
 
############################################################################
#
#           A DEFINITION
#
############################################################################
 
x = [1, 2, "hello"]            # `x` has type `Vector{Any}`

@btime sum($x[1:2])            # type UNSTABLE
 
x = [1, 2, 3]                  # `x` has type `Vector{Int64}`

@btime sum($x[1:2])            # type stable
 
############################################################################
#
#           TYPE STABILITY WITH VECTORS
#
############################################################################
 
x1::Vector{Int}     = [1, 2, 3]

sum(x1)             # type stable
 
x2::Vector{Int64}   = [1, 2, 3]

sum(x2)             # type stable
 
x3::Vector{Float64} = [1, 2, 3]

sum(x3)             # type stable
 
x4::BitVector       = [true, false, true]

all(x4)             # type stable (`all` checks whether all arguments are `true`)
 
x5::Vector{Number}  = [1, 2, 3]

sum(x5)             # type UNSTABLE -> `sum` considers all the posibilities given by `Number`
 
x6::Vector{Any}     = [1, 2, 3]

sum(x6)             # type UNSTABLE -> `sum` considers all the posibilities given by `Any`
 
############################################################################
#
#           TYPE STABILITY WITH VECTORS
#
############################################################################
 
function foo(x,y)
    a = (x > y) ?  x  :  y

    a * 2
end

foo(1, 2)           # type stable   -> `a * 2` is always `Int64`
 
function foo(x,y)
    a = (x > y) ?  x  :  y

    a * 2
end

foo(1, 2.5)         # type UNSTABLE -> `a * 2` is either `Int64` or `Float64`
 
