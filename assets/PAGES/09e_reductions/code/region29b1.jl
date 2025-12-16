Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = prod(log, x)       #same output as prod(log.(x))
@btime foo($x)     #hide