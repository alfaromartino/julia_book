using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = [sum(x .> x[i]) for i in eachindex(x)]

@btime foo($x) #hide