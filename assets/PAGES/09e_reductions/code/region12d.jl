using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = maximum(2 .* x)

@btime foo(ref($x))