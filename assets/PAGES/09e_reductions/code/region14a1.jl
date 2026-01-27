Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = sum(a -> 2 * a, x)       #same output as sum(2 .* x)
@ctime foo($x)     #hide