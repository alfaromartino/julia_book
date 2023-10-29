using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x  = rand(10)

foo(x) = sum(a -> 10 + 2a +  3a^2, x)

@btime foo(ref($x));