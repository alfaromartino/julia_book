x = [1, 2, 3]

foo(x)= sum(x[1:2])           # it allocates ONE vector -> the slice 'x[1:2]'

@btime foo(ref($x))