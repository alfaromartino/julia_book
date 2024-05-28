using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10)

foo(x) = sum(2 .* x)

@btime foo(ref($x)) #hide