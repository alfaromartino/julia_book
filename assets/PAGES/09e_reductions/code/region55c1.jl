Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = mapreduce(log, max, x)     #same output as maximum(log.(x))
@ctime foo($x) #hide