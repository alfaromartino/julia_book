using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = minimum(a -> 3 * a, x)

@btime foo(ref($x))     #hide