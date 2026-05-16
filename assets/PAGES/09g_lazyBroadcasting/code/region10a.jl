Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = 2 .* x
@ctime foo($x) #hide