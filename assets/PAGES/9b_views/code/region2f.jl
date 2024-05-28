#
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(a for a in x if a > 0.5)

@btime foo($x) #hide