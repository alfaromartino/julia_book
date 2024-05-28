x      = [1,2,3]
foo(x) = x .* x

@btime foo($x) #hide