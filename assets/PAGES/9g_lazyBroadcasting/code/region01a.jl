Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = exp.(2 * x) + (3 * x) * 5

@btime foo($x) #hide