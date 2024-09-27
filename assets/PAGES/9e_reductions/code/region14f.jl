using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = any(a -> a > 0.5, x)

@btime foo(ref($x))     #hide       #hide