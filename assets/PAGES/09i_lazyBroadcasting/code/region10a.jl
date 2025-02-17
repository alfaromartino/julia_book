Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = 2 .* x
@btime foo($x) #hide