x      = [1, 2, 3]

foo(x) = sum(@view(x[1:2]))    # it doesn't allocate
@ctime foo($x) #hide