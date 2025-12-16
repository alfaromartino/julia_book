using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10);   sx = SVector(x...)

foo(x) = sum(2 .* x)

@btime foo(ref($sx)) #hide