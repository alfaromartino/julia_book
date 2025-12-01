x = [1, 2, 3]

foo(x) = sum(x[1:2])           # allocations from the slice 'x[1:2]'

@btime foo($x) #hide