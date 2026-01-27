#
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(1_000)

foo(x) = sum(a for a in x if a > 0.5)

@ctime foo($x) #hide