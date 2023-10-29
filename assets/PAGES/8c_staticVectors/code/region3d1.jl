using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10);   sx = SA[x...]

foo(x) = sum(a -> 10 + 2a +  3a^2, x)

replicate(x) = [foo(x) for _ in 1:100_000]
@btime replicate(ref($sx));