x      = collect(1:10)
foo(x) = x .* 2

@btime foo(ref($x))