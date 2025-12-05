Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = maximum(a -> 2 * a, x)   #same output as maximum(2 .* x)
@btime foo($x)     #hide