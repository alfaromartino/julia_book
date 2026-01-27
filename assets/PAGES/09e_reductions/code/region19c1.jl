Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(max, x)         #same output as maximum(x)
@ctime foo($x) #hide