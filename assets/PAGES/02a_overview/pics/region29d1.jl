Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = minimum(log, x)    #same output as minimum(log.(x))
@btime foo($x)     #hide