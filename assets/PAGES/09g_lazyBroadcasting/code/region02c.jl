Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(a) = a * 2 + a * 3
@ctime foo.($x) #hide