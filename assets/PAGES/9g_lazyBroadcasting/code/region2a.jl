x        = (1, 2, 3)
y        = (4, 5, 6)

foo(a,b) = a * b

@btime foo.($x, $y) #hide