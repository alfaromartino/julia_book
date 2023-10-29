x      = [1,2,3]

foo(x) = 2 * sum(x)             

@btime foo(ref($x))