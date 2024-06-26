x        = (1, 2, 3)
y        = (4, 5, 6)

foo(x,y) = x .* y

@btime foo($x, $y) #hide