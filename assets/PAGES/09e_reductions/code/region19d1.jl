Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(min, x)         #same output as minimum(x)
@btime foo($x) #hide