Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = reduce(+, map(a -> 2 * a, x))
@btime foo($x)     #hide