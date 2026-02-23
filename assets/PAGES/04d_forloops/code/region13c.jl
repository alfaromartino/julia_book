list1 = ["A","B"]
list2 = [ 1 , 2 ]

X     = [(i,j) for (i,j) in Iterators.product(list1,list2)]    # this defines a matrix
print_asis(X)   #hide