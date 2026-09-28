#
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(1_000)

foo(x) = sum(Iterators.filter(>(0.5), x))

@ctime foo($x) #hide