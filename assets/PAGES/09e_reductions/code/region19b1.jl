Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(*, x)           #same output as prod(x)
@btime foo($x) #hide