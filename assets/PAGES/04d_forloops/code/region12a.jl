list1 = [1, 2]
list2 = [3, 4]

for (a,b) in Iterators.product(list1,list2)    #it takes all possible combinations
    println([a,b])
end