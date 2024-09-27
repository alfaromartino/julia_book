Random.seed!(123)       #setting the seed for reproducibility #hide
using LazyArrays
x      = rand(100)

foo(x) = sum(@~ 2 .* x)

@btime foo($x) #hide