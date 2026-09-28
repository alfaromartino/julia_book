Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(+, x)           #same output as sum(x)
@ctime foo($x) #hide