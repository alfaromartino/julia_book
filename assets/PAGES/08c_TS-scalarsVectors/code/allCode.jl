include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
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

output      = foo(x1,y1)        # type stable: mixing `Int64` and `Float64` results in `Float64`
 
print_asis(output)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
foo(x,y)    = x * y

x2::Float64 = 2               # this is converted to `2.0` 
y2          = 0.5

output      = foo(x2,y2)        # type stable: `x` and `y` are `Float64`, so output type is predictable
 
print_asis(output)   #hide
 
####################################################
#	Type Instability
####################################################
 
function foo(x,y)
    a = (x > y) ?  x  :  y

    [a * i for i in 1:100_000]
end

foo(1, 2)           # type stable   -> `a * i` is always `Int64`
@ctime foo(1, 2)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo(x,y)
    a = (x > y) ?  x  :  y

    [a * i for i in 1:100_000]
end

foo(1, 2.5)         # type UNSTABLE -> `a * i` is either `Int64` or `Float64`
@ctime foo(1, 2.5)  #hide
 
############################################################################
#
#           TYPE STABILITY WITH VECTORS
#
############################################################################
 
x = [1, 2, 2.5]      # automatic conversion to `Vector{Float64}`
print_asis(x)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
y = [1, 2.0, 3.0]    # automatic conversion to `Vector{Float64}`
print_asis(y)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
v1                 = [1, 2.0, 3.0]     # automatic conversion to `Vector{Float64}`  

w1::Vector{Int64}  = v1                # conversion to `Vector{Int64}`
 
print_asis(w1)  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
v2                 = [1, 2, 2.5]       # automatic conversion to `Vector{Float64}`  

w2::Vector{Number} = v2                # `w2` is still `Vector{Number}`
 
print_asis(w2)  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
nr_elements  = 3
z            = Vector{Any}(undef, nr_elements)     # `Vector{Any}` always

z           .= 1
 
print_asis(z)   #hide
 
####################################################
#	type instability
####################################################
 
z1::Vector{Int}     = [1, 2, 3]

sum(z1)             # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
z2::Vector{Int64}   = [1, 2, 3]

sum(z2)             # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
z3::Vector{Float64} = [1, 2, 3]

sum(z3)             # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
z4::BitVector       = [true, false, true]

sum(z4)             # type stable
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
z                  = [1, 2, 3]

sum(z)             # type stable

@ctime sum(z)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
z5::Vector{Number} = [1, 2, 3]

sum(z5)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Number`
@ctime sum(z5)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
z6::Vector{Any}    = [1, 2, 3]

sum(z6)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Any`
@ctime sum(z6)   #hide
 
