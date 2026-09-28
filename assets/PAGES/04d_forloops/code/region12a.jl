list1 = ["A","B"]
list2 = [ 1 , 2 ]

for (a,b) in Iterators.product(list1,list2)    #it takes all possible combinations
    println((a,b))
end