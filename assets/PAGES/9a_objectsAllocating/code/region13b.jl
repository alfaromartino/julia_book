x      = [1,2,3]

foo(x) = x[1] * x[2] + x[3]

@btime foo($x) #hide