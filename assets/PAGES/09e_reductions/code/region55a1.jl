Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = mapreduce(log, +, x)       #same output as sum(log.(x))
@btime foo($x) #hide