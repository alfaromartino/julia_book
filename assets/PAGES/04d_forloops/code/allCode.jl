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
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	alternatives
####################################################
 
for x in ["hello","beautiful","world"] 
    println(x)
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
for x ∈ ["hello","beautiful","world"] 
    println(x)
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
for x = ["hello","beautiful","world"] 
    println(x)
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# any term for iteration variable
 
for word in ["hello","beautiful","world"] 
    println(word)
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
for i in 3:-1:1
    println(i)
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# creating a vector from a range
 
x = collect(4:6)
print_asis(x)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	Iterating over Indices of an Array
####################################################
 
x = [4, 6, 8]

for i in 1:length(x)
    println(x[i])
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [4, 6, 8]

for i in eachindex(x)
    println(x[i])
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	methods to iterate over indices
####################################################
 
x = [4, 6, 8]

for i in eachindex(x)
    println(x[i])
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [4, 6, 8]

for i in 1:length(x)
    println(x[i])
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [4, 6, 8]

for i in LinearIndices(x) 
    println(x[i])
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [4, 6, 8]

for i in firstindex(x):lastindex(x)
    println(x[i])
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			VARIABLE SCOPE IN FOR-LOOPS
#
############################################################################
 
x = 2

for x in ["hello"]          # this 'x' is local, not related to 'x = 2'
    println(x)
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
#no `x` defined outside the for-loop

for word in ["hello"]
    x = word                # `x` is local to the for-loop, not available outside it
end
#print_asis(x) #ERROR   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	consequences of variable scope
####################################################
 
x = [2, 4, 6]

for i in eachindex(x)
    x[i] * 10            # refers to the `x` outside of the for-loop
end
print_asis(x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [2, 4, 6]

for word in ["hello"]
    x = word             # reassigns the `x` defined outside the for-loop
end
print_asis(x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			ARRAY COMPREHENSIONS
#
############################################################################
 
x      = [1,2,3]


y      = [a^2 for a in x]
z      = [x[i]^2 for i in eachindex(x)]
 
print_asis(y)   #hide
 
print_asis(z)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1,2,3]
foo(a) = a^2

y      = [foo(a) for a in x]
z      = [foo(x[i]) for i in eachindex(x)]
 
print_asis(y)   #hide
 
print_asis(z)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	array comprehensions with conditions
####################################################
 
x = [1, 2, 3, 4]

y = [a for a in x if a ≤ 2]
z = [x[i] for i in eachindex(x) if x[i] ≤ 2]
 
print_asis(y)   #hide
 
print_asis(z)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	array comprehensions for matrices
####################################################
 
y = [i * j for i in 1:2, j in 1:2]
print_asis(y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			ITERATING OVER MULTIPLE ITERABLE COLLECTIONS
#
############################################################################
 
list1 = ["A","B"]
list2 = [ 1 , 2 ]

for (a,b) in Iterators.product(list1,list2)    #it takes all possible combinations
    println((a,b))
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
list1 = ["A","B"]
list2 = [ 1 , 2 ]

for (a,b) in zip(list1,list2)                  #it takes pairs with the same index
    println((a,b))
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	array comprehensions
####################################################
 
list1 = ["A","B"]
list2 = [ 1 , 2 ]

x     = [(i,j) for i in list1 for j in list2]
print_asis(x)   #hide
 
list1 = ["A","B"]
list2 = [ 1 , 2 ]

x     = [(i,j) for (i,j) in zip(list1,list2)]
print_asis(x)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			Simultaneously Iterating over Indices and Values
#
############################################################################
 
x = ["hello", "world"]

for (index,value) in enumerate(x)
    println("$index $value")
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [10, 20]


y = [index * value for (index,value) in enumerate(x)]
print_asis(y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			ITERATING OVER FUNCTIONS
#
############################################################################
 
x                        = [10, 50, 100]
list_functions           = [maximum, minimum]

descriptive(vector,list) = [foo(vector) for foo in list]
print_asis(descriptive(x, list_functions))  #hide
 
