Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = maximum(log, x)    #same output as maximum(log.(x))
@btime foo($x)     #hide