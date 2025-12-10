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
 
# necessary packages for this file
using StatsBase
 
############################################################################
#
#           SORTING VECTORS
#
############################################################################
 
x = [4, 5, 3, 2]

y = sort(x)
 
println(x)
 
println(y)
 



x = [4, 5, 3, 2]

y = sort(x, rev=true)
 
println(x)
 
println(y)
 



x = [4, 5, 3, 2]

sort!(x)
println(x)
 



####################################################
#	option 'by'
####################################################
 
x      = [4, -5, 3]


y      = sort(x, by = abs)      # 'abs' computes the absolute value
 
println(abs.(x))
 
println(y)
 



x      = [4, -5, 3]

foo(a) = a^2
y      = sort(x, by = foo)      # same as sort(x, by = x -> x^2)
 
println(foo.(x))
 
println(y)
 



x      = [4, -5, 3]

foo(a) = -a
y      = sort(x, by = foo)      # same as sort(x, by = x -> -x)
 
println(foo.(x))
 
println(y)
 



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
println(sort_index)
 



x          = [3, 4, 5, 6]

sort_index = sortperm(x)
println(sort_index)
 



x          = [1, 3, 4, 2]

sort_index = sortperm(x)
println(sort_index)
 



####################################################
#	option `rev`
####################################################
 
x          = [9, 3, 2, 1]

sort_index = sortperm(x, rev=true)
println(sort_index)
 



x          = [9, 5, 3, 1]

sort_index = sortperm(x, rev=true)
println(sort_index)
 



x          = [9, 3, 5, 1]

sort_index = sortperm(x, rev=true)
println(sort_index)
 



####################################################
#	option `by`
####################################################
 
x      = [4, -5, 3]


value  = sort(x, by = abs)      # 'abs' computes the absolute value
index  = sortperm(x, by = abs)
 
println(abs.(x))
 
println(value)
 
println(index)
 



x      = [4, -5, 3]

foo(a) = a^2
value  = sort(x, by = foo)      # same as sort(x, by = x -> x^2)
index  = sortperm(x, by = foo)
 
println(foo.(x))
 
println(value)
 
println(index)
 



x      = [4, -5, 3]

foo(a) = -a
value  = sort(x, by = foo)      # same as sort(x, by = x -> -x)
index  = sortperm(x, by = foo)
 
println(foo.(x))
 
println(value)
 
println(index)
 



####################################################
#	an example
####################################################
 
days             = ["one", "two", "three"]
failures         = [8, 2, 4]

index            = sortperm(failures)
days_by_failures = days[index]        # days sorted by lowest failures
 
println(index)
 
println(days_by_failures)
 



############################################################################
#
#           REMOVING DUPLICATES
#
############################################################################
 
x = [2, 2, 3, 4]

y = unique(x)       # returns a new vector
 
println(x)
 
println(y)
 



x = [2, 2, 3, 4]

unique!(x)          # mutates 'x'
println(x)
 



####################################################
#	COUNTING OCCURRENCES
####################################################
 
using StatsBase
x           = [6, 6, 0, 5]

y           = countmap(x)              # Dict with `element => occurrences`

elements    = collect(keys(y))
occurrences = collect(values(y))
 
println(y)
 
println(elements)
 
println(occurrences)
 



using StatsBase
x           = [6, 6, 0, 5]

y           = sort(countmap(x))        # OrderedDict with `element => occurrences`

elements    = collect(keys(y))
occurrences = collect(values(y))
 
println(y)
 
println(elements) #ide
 
println(occurrences)
 



############################################################################
#
#           ROUNDING NUMBERS
#
############################################################################
 
x = 456.175

round(x)                    # 456.0   

round(x, digits=1)          # 456.2
round(x, digits=2)          # 456.18

round(Int, x)               # 456

round(x, sigdigits=1)       # 500.0
round(x, sigdigits=2)       # 460.0
 



x = 456.175

floor(x)                    # 456.0

floor(x, digits=1)          # 456.1
floor(x, digits=2)          # 456.17

floor(Int, x)               # 456

floor(x, sigdigits=1)       # 400.0
floor(x, sigdigits=2)       # 450.0
 



x = 456.175

ceil(x)                     # 457.0

ceil(x, digits=1)           # 456.2
ceil(x, digits=2)           # 456.18   

ceil(Int, x)                # 457   

ceil(x, sigdigits=1)        # 500.0
ceil(x, sigdigits=2)        # 460.0
 



############################################################################
#
#			RANKINGS
#
############################################################################
 
using StatsBase
x = [6, 6, 0, 5]

y = competerank(x)
println(y)
 



using StatsBase
x = [6, 6, 0, 5]

y = competerank(x, rev=true)
println(y)
 



using StatsBase
x = [6, 6, 0, 5]

y = ordinalrank(x)
println(y)
 



using StatsBase
x = [6, 6, 0, 5]

y = ordinalrank(x, rev=true)
println(y)
 



####################################################
#	Do not confuse `ordinalrank` and `sortperm`
####################################################
 
using StatsBase
x = [3, 1, 2]

y = ordinalrank(x)
println(y)
 



using StatsBase
x = [3, 1, 2]

y = sortperm(x)
println(y)
 
############################################################################
#
#           EXTREMA (MAXIMUM AND MINIMUM)
#
############################################################################
 
x = [6, 6, 0, 5]

y = maximum(x)
println(y)
 



x = [6, 6, 0, 5]

y = argmax(x)
println(y)
 



x = [6, 6, 0, 5]

y = findmax(x)
println(y)
 



####################################################
#	max function
####################################################
 
x = 3
y = 4

z = max(x,y)
println(z)
 
