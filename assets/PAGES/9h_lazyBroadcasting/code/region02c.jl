Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(a) = a * 2 + a * 3
@btime foo.($x) #hide