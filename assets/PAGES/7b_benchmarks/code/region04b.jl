using Random; Random.seed!(1234) #hide
x      = rand(100_000)

foo(x) = sum(a -> 2 * a, x)

@btime foo($x)    #hide