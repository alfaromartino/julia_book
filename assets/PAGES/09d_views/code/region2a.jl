Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@ctime foo($x) #hide