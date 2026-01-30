Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(10)

foo(x) = sum(2 .* x)

@ctime foo($x) #hide