include(joinpath(homedir(), "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Statistics, BenchmarkTools, Chairmarks
 
############################################################################
#
#           A DEFINITION
#
############################################################################
 
x = [1, 2, 3]                  # `x` has type `Vector{Int64}`

@btime sum($x[1:2])            # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [1, 2, "hello"]            # `x` has type `Vector{Any}`

@btime sum($x[1:2])            # type UNSTABLE
 
############################################################################
#
#           TYPE STABILITY WITH SCALARS
#
############################################################################
 
function foo(x,y)
    a = (x > y) ?  x  :  y

    [a * i for i in 1:100_000]
end

foo(1, 2)           # type stable   -> `a * i` is always `Int64`
@btime foo(1, 2)            # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo(x,y)
    a = (x > y) ?  x  :  y

    [a * i for i in 1:100_000]
end

foo(1, 2.5)         # type UNSTABLE -> `a * i` is either `Int64` or `Float64`
@btime foo(1, 2.5)            # hide
 
############################################################################
#
#           TYPE STABILITY WITH VECTORS
#
############################################################################
 
x1::Vector{Int}     = [1, 2, 3]

sum(x1)             # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x2::Vector{Int64}   = [1, 2, 3]

sum(x2)             # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x3::Vector{Float64} = [1, 2, 3]

sum(x3)             # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x4::BitVector       = [true, false, true]

sum(x4)             # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                  = [1, 2, 3]

sum(x)             # type stable
@btime sum(x)   # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x5::Vector{Number} = [1, 2, 3]

sum(x5)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Number`
@btime sum(x5)   # hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x6::Vector{Any}     = [1, 2, 3]

sum(x6)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Any`
@btime sum(x6)   # hide
 
