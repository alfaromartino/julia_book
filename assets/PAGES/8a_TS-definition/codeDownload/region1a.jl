x      = rand(10)
foo(x) = sum(x)

@btime foo(ref($x))
#@code_warntype foo() # hide