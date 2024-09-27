using Skipper
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(skip(≤(0.5), x))

@btime foo($x) #hide