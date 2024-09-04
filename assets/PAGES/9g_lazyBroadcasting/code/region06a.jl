Random.seed!(1234) # hide
x      = rand(1_000)

foo(x) = x ./ sum(x)

@btime foo($x)    # hide