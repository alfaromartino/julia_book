Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = minimum(a -> 2 * a, x)   #same output as minimum(2 .* x)
@ctime foo($x)     #hide