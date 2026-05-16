Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)
β = 1.5

foo(x,β) = exp.(β * x) + (β * x) * 5

@btime foo($x, $β) #hide