Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(min, x)         #same output as minimum(x)
@ctime foo($x) #hide