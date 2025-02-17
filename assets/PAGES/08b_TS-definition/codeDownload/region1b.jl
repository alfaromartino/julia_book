x     = rand(10)
foo() = sum(x)

@btime foo()
#@code_warntype foo() # hide