include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#           SECTION: "VECTOR INITIALIZATION AND CREATION "
#
############################################################################
 
############################################################################
#
#   INITIALIZING VECTORS
#
############################################################################
 
x_length = 3

x        = Vector{Int64}(undef, x_length)  # `x` can hold `Int64` values, and is initialized with 3 undefined elements
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
y        = [3,4,5]

x        = similar(y)                      # `x` has the same type as `y`, which is Vector{Int64}(undef, 3)
print_asis(x) #hide
 
############################################################################
#
#   CREATING VECTORS WITH GIVEN VALUES
#
############################################################################
 
####################################################
#	RANGES
####################################################
 
some_range = 2:5

x          = collect(some_range)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 0: 1/5 : 1                          # operation applied below, but without the function 'range'
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = range(0, 1, 5)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = range(start=0, stop=1, length=5)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = range(start=0, length=5, stop=1)    # any order for keyword arguments
print_asis(x) #hide
 
####################################################
#   SAME VALUE REPEATED
####################################################
 
# ZEROS OR ONES
 
length_vector = 3

x             = zeros(length_vector)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
length_vector = 3

x             = ones(length_vector)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
length_vector = 3

x             = zeros(Int, length_vector)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
length_vector = 3

x             = ones(Int, length_vector)
print_asis(x) #hide
 
# WITH BOOLEAN VALUES
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
length_vector = 3

x             = trues(length_vector)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
length_vector = 3

x             = falses(length_vector)
print_asis(x) #hide
 
# ARBITRARY VALUE
 
length_vector  = 3
filling_object = [1,2]

x              = fill(filling_object, length_vector)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
length_vector  = 3
filling_object = 1

x              = fill(filling_object, length_vector)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
length_vector  = 3
filling_object = [1]

x              = fill(filling_object, length_vector)
print_asis(x) #hide
 
####################################################
#	CONCATENATED VECTORS
####################################################
 
# vcat
 
x = [3,4,5]
y = [6,7,8]


z = vcat(x,y)
print_asis(z) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [3,4,5]
y = [6,7,8]


z = [x ; y]
print_asis(z) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [3,4,5]
y = [6,7,8]

A = [x, y]
z = vcat(A...)
print_asis(z) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	WITH ELEMENTS OF AN OBJECT REPEATED
####################################################
 
nr_repetitions     = 3
elements_to_repeat = [1,2]

x                  = repeat(elements_to_repeat, nr_repetitions)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
nr_repetitions     = 3
elements_to_repeat = [1]

x                  = repeat(elements_to_repeat, nr_repetitions)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
nr_repetitions     = 3
elements_to_repeat = 1

# x                = repeat(elements_to_repeat, nr_repetitions)   #ERROR
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# difference with `fill`
 
nr_repetitions     = 3
elements_to_repeat = [1,2]

x                  = repeat(filling_object, nr_repetitions)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
length_vector      = 3
filling_object     = [1,2]

x                  = fill(filling_object, length_vector)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
length_vector      = 3
filling_object     = [1,2]

temp               = fill(filling_object, length_vector)
x                  = vcat(temp...)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#           ADDING, REMOVING, AND REPLACING ELEMENTS (optional)
#
############################################################################
 
x                 = [3,4,5]
element_to_insert = 0


push!(x, element_to_insert)                 # add 0 as last element - faster
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                 = [3,4,5]
element_to_insert = 0


pushfirst!(x, element_to_insert)            # add 0 as first element - slower
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                 = [3,4,5]
element_to_insert = 0
at_index          = 2

insert!(x, at_index, element_to_insert)     # add 0 at index 2
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                 = [3,4,5]
vector_to_insert  = [6,7]


append!(x, vector_to_insert)                # add 6 and 7 as last elements
print_asis(x) #hide
 
############################################################################
#
#           REMOVING ELEMENTS OF A VECTOR
#
############################################################################
 
x                  = [5,6,7]


pop!(x)                            # delete last element
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                  = [5,6,7]


popfirst!(x)                       # delete first element
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                  = [5,6,7]
index_of_removal   = 2

deleteat!(x, index_of_removal)     # delete element at index 2
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                  = [5,6,7]
indices_of_removal = [1,3]

deleteat!(x, indices_of_removal)   # delete elements at indices 1 and 3
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x               = [5,6,7]
index_to_keep   = 2

keepat!(x, index_to_keep)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x               = [5,6,7]
indices_to_keep = [2,3]

keepat!(x, index_to_keep)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [3,3,5]

replace!(x, 3 => 0)              # in-place (it updates x)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [3,3,5]

y = replace(x, 3 => 0)           # new copy
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [3,3,5]

replace!(x, 3 => 0, 5 => 1)      # in-place (it updates x)
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [3,3,5]

y = replace(x, 3 => 0, 5 => 1)   # new copy 
print_asis(y) #hide
 
