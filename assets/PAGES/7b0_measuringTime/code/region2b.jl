x      = collect(1:10)
foo()  = x .* 2

@btime foo()