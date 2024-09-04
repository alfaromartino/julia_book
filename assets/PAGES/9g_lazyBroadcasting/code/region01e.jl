Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(a) = exp(2 * a) + (3 * a) * 5

@btime foo.($x) #hide