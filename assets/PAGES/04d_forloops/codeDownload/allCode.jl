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
#			FOR-LOOPS
#
############################################################################
 
############################################################################
#
#			SYNTAX
#
############################################################################
 
for x in ["hello","beautiful","world"]
    println(x)
end
 



####################################################
#	alternatives
####################################################
 
for x in ["hello","beautiful","world"] 
    println(x)
end
 



for x ∈ ["hello","beautiful","world"] 
    println(x)
end
 



for x = ["hello","beautiful","world"] 
    println(x)
end
 



# any term for iteration variable
 
for word in ["hello","beautiful","world"] 
    println(word)
end
 



############################################################################
#
#			ITERATING OVER INDICES
#
############################################################################
 
####################################################
#	ranges
####################################################
 
for i in 1:2:5
    println(i)
end
 



for i in 3:-1:1
    println(i)
end
 



# creating a vector from a range
 
x = collect(4:6)
println(x)
 



####################################################
#	Iterating over Indices of an Array
####################################################
 
x = [4, 6, 8]

for i in 1:length(x)
    println(x[i])
end
 



x = [4, 6, 8]

for i in eachindex(x)
    println(x[i])
end
 



####################################################
#	methods to iterate over indices
####################################################
 
x = [4, 6, 8]

for i in eachindex(x)
    println(x[i])
end
 



x = [4, 6, 8]

for i in 1:length(x)
    println(x[i])
end
 



x = [4, 6, 8]

for i in LinearIndices(x) 
    println(x[i])
end
 



x = [4, 6, 8]

for i in firstindex(x):lastindex(x)
    println(x[i])
end
 



############################################################################
#
#			VARIABLE SCOPE IN FOR-LOOPS
#
############################################################################
 
x = 2

for x in ["hello"]          # this 'x' is local, not related to 'x = 2'
    println(x)
end
 



#no `x` defined outside the for-loop

for word in ["hello"]
    x = word                # `x` is local to the for-loop, not available outside it
end
#println(x) #ERROR
 



####################################################
#	consequences of variable scope
####################################################
 
x = [2, 4, 6]

for i in eachindex(x)
    x[i] * 10            # refers to the `x` outside of the for-loop
end
println(x)
 



x = [2, 4, 6]

for word in ["hello"]
    x = word             # reassigns the `x` defined outside the for-loop
end
println(x)
 



############################################################################
#
#			ARRAY COMPREHENSIONS
#
############################################################################
 
x      = [1,2,3]


y      = [a^2 for a in x]        # or y = [x[i]^2 for i in eachindex(x)]
println(y)
 



x      = [1,2,3]

foo(a) = a^2
y      = [foo(a) for a in x]     # or y = [foo(x[i]) for i in eachindex(x)]
println(y)
 



####################################################
#	array comprehensions with conditions
####################################################
 
x = [i for i in 1:4 if i ≤ 3]
println(x)
 



####################################################
#	array comprehensions for matrices
####################################################
 
y = [i * j for i in 1:2, j in 1:2]
println(y)
 



############################################################################
#
#			ITERATING OVER MULTIPLE OBJECTS
#
############################################################################
 
list1 = [1, 2]
list2 = [3, 4]

for (a,b) in Iterators.product(list1,list2)    #it takes all possible combinations
    println([a,b])
end
 



list1 = [1, 2]
list2 = [3, 4]

for (a,b) in zip(list1,list2)                  #it takes pairs with the same index
    println([a,b])
end
 



####################################################
#	using zip
####################################################
 
x = [i * j for i in 1:2 for j in 1:2]
println(x)
 
x = [i * j for (i,j) in zip(1:2, 1:2)]
println(x)
 



############################################################################
#
#			Simultaneously Iterating over Indices and Values
#
############################################################################
 
x = ["hello", "world"]

for (index,value) in enumerate(x)
    println("$index $value")
end
 



x = [10, 20]


y = [index * value for (index,value) in enumerate(x)]
println(y)
 



############################################################################
#
#			ITERATING OVER FUNCTIONS
#
############################################################################
 
x                        = [10, 50, 100]
list_functions           = [maximum, minimum]

descriptive(vector,list) = [foo(vector) for foo in list]
println(descriptive(x, list_functions))
 
