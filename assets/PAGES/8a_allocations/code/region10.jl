x      = [1,2,3]

foo(x) = x[1:2]                 # ONE allocation, since ranges don't allocates (but 'x[1:2]' itself does)

@btime foo(ref($x))