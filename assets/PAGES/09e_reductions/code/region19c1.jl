Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(max, x)         #same output as maximum(x)
@btime foo($x) #hide