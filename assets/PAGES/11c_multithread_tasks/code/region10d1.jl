Random.seed!(1234) #hide
x      = rand(10_000_000)
foo(x) = sum(x)

@ctime foo($x) #hide