Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = mapreduce(log, min, x)     #same output as minimum(log.(x))
@ctime foo($x) #hide