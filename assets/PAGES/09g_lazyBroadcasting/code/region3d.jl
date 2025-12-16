Random.seed!(123)       #setting seed for reproducibility #hide
using LazyArrays
x      = rand(100)

foo(x) = sum(@~ 2 .* x)
@ctime foo($x) #hide