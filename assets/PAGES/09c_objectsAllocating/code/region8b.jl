x      = [1,2,3]
foo(x) = x .* x

@ctime foo($x) #hide