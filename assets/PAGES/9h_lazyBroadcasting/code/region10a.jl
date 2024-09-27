Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(1_000)

foo(x) = 2 .* x
@btime foo($x) #hide