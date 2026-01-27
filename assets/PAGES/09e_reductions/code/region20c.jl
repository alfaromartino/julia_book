Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = mapreduce(a -> 2 * a, +, x)
@ctime foo($x)     #hide