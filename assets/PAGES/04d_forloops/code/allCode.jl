include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
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
print_asis(x)   #hide
 
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
#print_asis(x) #ERROR   #hide
 
####################################################
#	consequences of variable scope
####################################################
 
x = [2, 4, 6]

for i in eachindex(x)
    x[i] * 10        # refers to the `x` outside of the for-loop
end
print_asis(x)     #hide
 
x = [2, 4, 6]

for word in ["hello"]
    x = word                        # it reassigns the `x` defined outside the for-loop
end
print_asis(x)     #hide
 
############################################################################
#
#			ARRAY COMPREHENSIONS
#
############################################################################
 
x      = [1,2,3]


y      = [a^2 for a in x]        # or y = [x[i]^2 for i in eachindex(x)]
print_asis(y)   #hide
 
x      = [1,2,3]

foo(a) = a^2
y      = [foo(a) for a in x]     # or y = [foo(x[i]) for i in eachindex(x)]
print_asis(y)   #hide
 
####################################################
#	array comprehensions with conditions
####################################################
 
x = [i for i in 1:4 if i ≤ 3]
print_asis(x)   #hide
 
####################################################
#	array comprehensions for matrices
####################################################
 
y = [i * j for i in 1:2, j in 1:2]
print_asis(y)   #hide
 
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
print_asis(x)   #hide
 
x = [i * j for (i,j) in zip(1:2, 1:2)]
print_asis(x)   #hide
 
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
print_asis(y)   #hide
 
############################################################################
#
#			ITERATING OVER FUNCTIONS
#
############################################################################
 
x                        = [10, 50, 100]
list_functions           = [maximum, minimum]

descriptive(vector,list) = [foo(vector) for foo in list]
print_asis(descriptive(x, list_functions))
 
