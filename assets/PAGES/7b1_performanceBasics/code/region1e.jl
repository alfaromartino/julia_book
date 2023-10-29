using Statistics

x     = rand(10)
foo() = sum(x) * prod(x) * mean(x) * std(x)

@btime foo()