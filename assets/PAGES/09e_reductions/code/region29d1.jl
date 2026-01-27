Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = minimum(log, x)    #same output as minimum(log.(x))
@ctime foo($x)     #hide