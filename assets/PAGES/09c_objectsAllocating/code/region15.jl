x      = [1,2,3]
foo(x) = sum(x .* x)                # allocations from temporary vector 'x .* x' 

@ctime foo($x) #hide