Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = mapreduce(log, +, x)       #same output as sum(log.(x))
@ctime foo($x) #hide