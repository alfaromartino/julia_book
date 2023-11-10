using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo(ref($x))