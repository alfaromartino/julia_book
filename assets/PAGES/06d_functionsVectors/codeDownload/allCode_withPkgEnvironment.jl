####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


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
#           SORT
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
# SORTPERM -> indices of the sorted vector
#
############################################################################
 
x          = [1, 2, 3, 4]

sort_index = sortperm(x)
println(sort_index)
 

x          = [3, 4, 5, 6]

sort_index = sortperm(x)
println(sort_index)
 

x          = [1, 3, 4, 2]

sort_index = sortperm(x)
println(sort_index)
 

x          = [9, 3, 2, 1]

sort_index = sortperm(x, rev=true)
println(sort_index)
 

x          = [9, 5, 3, 1]

sort_index = sortperm(x, rev=true)
println(sort_index)
 

x          = [9, 3, 5, 1]

sort_index = sortperm(x, rev=true)
println(sort_index)
 

x          = [9, 3, 5, 1]

sort_index = sortperm(x, rev=true)
println(sort_index)
 

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
 

days     = [1, 2, 3]
failures = [8, 2, 4]

index            = sortperm(failures, rev=true)
days_by_failures = days[index]                     # days sorted by highest earnings
 
println(index)
 
println(days_by_failures)
 

days     = ["one", "two", "three"]
failures = [8, 2, 4]

index            = sortperm(failures)
days_by_failures = days[index]                     # days sorted by lowest failures
 
println(index)
 
println(days_by_failures)
 
############################################################################
#
#           UNIQUE ELEMENTS
#
############################################################################
 

x = [2, 2, 3, 4]

y = unique(x)       # returns a new vector
 
println(x)
 
println(y)
 

x = [2, 2, 3, 4]

unique!(x)          # mutates 'x'
println(x)
 

x = [2, 2, 3]

y = allunique(x)    # Boolean - true if all elements are unique
println(y)
 
############################################################################
#
#           COUNTING OCCURRENCES
#
############################################################################
 
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
 

using StatsBase

function to_sort_x(x)
    dict_count = countmap(x)
    sorted_x   = sort(x, by = (x -> dict_count[x]))
    return sorted_x
end

x        = [0, 4, 4, 4, 5, 5]
sorted_x = to_sort_x(x)
 
println(x, 10)
 
println(sorted_x, 10)
 
############################################################################
#
#           ROUNDING ELEMENTS
#
############################################################################
 
#########
# ROUND
#########
 
x = 456.175

round(x)                         # 456.0   

round(x, digits=1)               # 456.2
round(x, digits=2)               # 456.18

round(Int, x)                    # 456

round(x, sigdigits=1)            # 500.0
round(x, sigdigits=2)            # 460.0
 

#########
# FLOOR
#########
 
x = 456.175

floor(x)                         # 456.0

floor(x, digits=1)               # 456.1
floor(x, digits=2)               # 456.17

floor(Int, x)                    # 456

floor(x, sigdigits=1)            # 400.0
floor(x, sigdigits=2)            # 450.0
 

#########
# CEIL
#########
 
x = 456.175

ceil(x)                          # 457.0

ceil(x, digits=1)                # 456.2
ceil(x, digits=2)                # 456.18   

ceil(Int, x)                     # 457   

ceil(x, sigdigits=1)             # 500.0
ceil(x, sigdigits=2)             # 460.0
 
###############################################
# DON'T CONFUSE competerank AND sortperm
###############################################
 
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
#           EXTREMA
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
 

x = 3
y = 4

z = max(x,y)
println(z)
 
