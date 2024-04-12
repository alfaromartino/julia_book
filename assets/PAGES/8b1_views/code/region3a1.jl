using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100_000)

foo(x) = max.(x[1:2:length(x)], 0.5)

@btime foo(ref($x)) #hide