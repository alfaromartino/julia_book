Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

foo(x)  = x * 2 + x * 3
@ctime foo($x) #hide