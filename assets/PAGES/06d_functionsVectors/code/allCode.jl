include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using StatsBase
 
############################################################################
#
#           SORTING VECTORS
#
############################################################################
 
x = [4, 5, 3, 2]

y = sort(x)
 
print_asis(x) #hide
 
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [4, 5, 3, 2]

y = sort(x, rev=true)
 
print_asis(x) #hide
 
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [4, 5, 3, 2]

sort!(x)
print_asis(x) #hide
 
####################################################
#	option 'by'
####################################################
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [4, -5, 3]


y      = sort(x, by = abs)      # 'abs' computes the absolute value
 
print_asis(abs.(x)) #hide
 
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [4, -5, 3]

foo(a) = a^2
y      = sort(x, by = foo)      # same as sort(x, by = x -> x^2)
 
print_asis(foo.(x)) #hide
 
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [4, -5, 3]

foo(a) = -a
y      = sort(x, by = foo)      # same as sort(x, by = x -> -x)
 
print_asis(foo.(x)) #hide
 
print_asis(y) #hide
 
############################################################################
#
#			RETRIEVING INDICES OF SORTED ELEMENTS
#
############################################################################
 
####################################################
#	SORTPERM -> indices of the sorted vector
####################################################
 
x          = [1, 2, 3, 4]

sort_index = sortperm(x)
print_asis(sort_index) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [3, 4, 5, 6]

sort_index = sortperm(x)
print_asis(sort_index) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [1, 3, 4, 2]

sort_index = sortperm(x)
print_asis(sort_index) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	option `rev`
####################################################
 
x          = [9, 3, 2, 1]

sort_index = sortperm(x, rev=true)
print_asis(sort_index) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [9, 5, 3, 1]

sort_index = sortperm(x, rev=true)
print_asis(sort_index) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [9, 3, 5, 1]

sort_index = sortperm(x, rev=true)
print_asis(sort_index) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	option `by`
####################################################
 
x      = [4, -5, 3]


value  = sort(x, by = abs)      # 'abs' computes the absolute value
index  = sortperm(x, by = abs)
 
print_asis(abs.(x)) #hide
 
print_asis(value) #hide
 
print_asis(index) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [4, -5, 3]

foo(a) = a^2
value  = sort(x, by = foo)      # same as sort(x, by = x -> x^2)
index  = sortperm(x, by = foo)
 
print_asis(foo.(x)) #hide
 
print_asis(value) #hide
 
print_asis(index) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [4, -5, 3]

foo(a) = -a
value  = sort(x, by = foo)      # same as sort(x, by = x -> -x)
index  = sortperm(x, by = foo)
 
print_asis(foo.(x)) #hide
 
print_asis(value) #hide
 
print_asis(index) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	an example
####################################################
 
days             = ["one", "two", "three"]
failures         = [8, 2, 4]

index            = sortperm(failures)
days_by_failures = days[index]        # days sorted by lowest failures
 
print_asis(index) #hide
 
print_asis(days_by_failures) #hide
 
############################################################################
#
#           REMOVING DUPLICATES
#
############################################################################
 
x = [2, 2, 3, 4]

y = unique(x)       # returns a new vector
 
print_asis(x) #hide
 
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [2, 2, 3, 4]

unique!(x)          # mutates 'x'
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	COUNTING OCCURRENCES
####################################################
 
using StatsBase
x           = [6, 6, 0, 5]

y           = countmap(x)              # Dict with `element => occurrences`

elements    = collect(keys(y))
occurrences = collect(values(y))
 
print_asis(y) #hide
 
print_asis(elements) #hide
 
print_asis(occurrences) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using StatsBase
x           = [6, 6, 0, 5]

y           = sort(countmap(x))        # OrderedDict with `element => occurrences`

elements    = collect(keys(y))
occurrences = collect(values(y))
 
print_asis(y) #hide
 
print_asis(elements) #ide
 
print_asis(occurrences) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#           ROUNDING NUMBERS
#
############################################################################
 
x = 456.175

round(x)                         # 456.0   

round(x, digits=1)               # 456.2
round(x, digits=2)               # 456.18

round(Int, x)                    # 456

round(x, sigdigits=1)            # 500.0
round(x, sigdigits=2)            # 460.0
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 456.175

floor(x)                         # 456.0

floor(x, digits=1)               # 456.1
floor(x, digits=2)               # 456.17

floor(Int, x)                    # 456

floor(x, sigdigits=1)            # 400.0
floor(x, sigdigits=2)            # 450.0
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 456.175

ceil(x)                          # 457.0

ceil(x, digits=1)                # 456.2
ceil(x, digits=2)                # 456.18   

ceil(Int, x)                     # 457   

ceil(x, sigdigits=1)             # 500.0
ceil(x, sigdigits=2)             # 460.0
 
############################################################################
#
#			RANKINGS
#
############################################################################
 
using StatsBase
x = [6, 6, 0, 5]

y = competerank(x)
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using StatsBase
x = [6, 6, 0, 5]

y = competerank(x, rev=true)
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using StatsBase
x = [6, 6, 0, 5]

y = ordinalrank(x)
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using StatsBase
x = [6, 6, 0, 5]

y = ordinalrank(x, rev=true)
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	Do not confuse `ordinalrank` and `sortperm`
####################################################
 
using StatsBase
x = [3, 1, 2]

y = ordinalrank(x)
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using StatsBase
x = [3, 1, 2]

y = sortperm(x)
print_asis(y) #hide
 
############################################################################
#
#           EXTREMA (MAXIMUM AND MINIMUM)
#
############################################################################
 
x = [6, 6, 0, 5]

y = maximum(x)
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [6, 6, 0, 5]

y = argmax(x)
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [6, 6, 0, 5]

y = findmax(x)
print_asis(y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	max function
####################################################
 
x = 3
y = 4

z = max(x,y)
print_asis(z) #hide
 
