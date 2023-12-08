using Statistics

x      = rand(10)
foo(x) = sum(x) * prod(x) * mean(x) * std(x)

@btime foo(ref($x))