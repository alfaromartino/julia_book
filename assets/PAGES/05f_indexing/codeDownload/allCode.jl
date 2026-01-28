############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
############################################################################
#
#			SECTION: "ARRAY INDEXING"
#
############################################################################
 
############################################################################
#
#           LOGICAL INDEXING
#
############################################################################
 
x = [1,2,3]
y = [true, false, true]
 
println(x[y])
 



############################################################################
#
#			OPERATORS AND FUNCTIONS FOR LOGICAL INDEXING
#
############################################################################
 
####################################################
#	indexing via broadcasting
####################################################
 
x            = [1, 2, 3, 100, 200]

y            = x[x .< 10]
 
println(y)
 



x            = [1, 2, 3, 100, 200]

condition(a) = (a < 10)             #function to eventually broadcast
y            = x[condition.(x)]
 
println(y)
 



####################################################
#	more complex indexing via broadcasting
####################################################
 
x            = [3, 6, 8, 100]

# numbers greater than 5, lower than 10, but not including 8
y            = x[(x .> 5) .&& (x .< 10) .&& (x .≠ 8)]
 
println(y)
 



x            = [3, 6, 8, 100]

# numbers greater than 5, lower than 10, but not including 8
y            = x[@. (x > 5) && (x < 10) && (x ≠ 8)]
 
println(y)
 



x            = [3, 6, 7, 8, 100]

# numbers greater than 5, lower than 10, but not including 8
condition(a) = (a > 5) && (a < 10) && (a ≠ 8)           #function to eventually broadcast
y            = x[condition.(x)]
 
println(y)
 



############################################################################
#
#			LOGICAL INDEXING VIA 'in' and '∈'
#
############################################################################
 
x            = [-100, 2, 4, 100]
list         = [minimum(x), maximum(x)]

# logical indexing (both versions are equivalent)
bool_indices = in.(x, Ref(list))    #`Ref(list)` can be replaced by `(list,)`
bool_indices = (∈).(x,Ref(list))

y            = x[bool_indices]
 
println(bool_indices)
 
println(y)
 



x            = [-100, 2, 4, 100]
list         = [minimum(x), maximum(x)]

# logical indexing
bool_indices = x .∈ Ref(list)            #only option, not possible to broadcast `in`


y            = x[bool_indices]
 
println(bool_indices)
 
println(y)
 



####################################################
#	remark - curried 'in'
####################################################
 
x            = [-100, 2, 4, 100]
list         = [minimum(x), maximum(x)]

#logical indexing
bool_indices = in(list).(x)   #no need to use `Ref(list)`
y            = x[bool_indices]
 
println(bool_indices)
 
println(y)
 
####################################################
#	remark - negation 'in' and negation '∈'
####################################################
 
x            = [-100, 2, 4, 100]
list         = [minimum(x), maximum(x)]

#identical vectors for logical indexing
bool_indices = (!in).(x, Ref(list))
bool_indices = (∉).(x, Ref(list))          #or `(!∈).(x, Ref(list))`
y            = x[bool_indices]
 
println(bool_indices)
 
println(y)
 



x            = [-100, 2, 4, 100]
list         = [minimum(x), maximum(x)]

#vector for logical indexing
bool_indices = x .∉ Ref(list)

y            = x[bool_indices]
 
println(bool_indices)
 
println(y)
 



############################################################################
#
#			THE FUNCTIONS 'findall' AND 'filter'
#
############################################################################
 
####################################################
#	'filter'
####################################################
 
x = [5, 6, 7, 8, 9]

y = filter(a -> a < 7, x)
 
println(y)
 



####################################################
#	'findall'
####################################################
 
x = [5, 6, 7, 8, 9]

y = findall(a -> a < 7, x)
z = x[findall(a -> a < 7, x)]
 
println(y)
 
println(z)
 



x = [5, 6, 7, 8, 9]

y = findall(x .< 7)
z = x[findall(x .< 7)]
 
println(y)
 
println(z)
 



