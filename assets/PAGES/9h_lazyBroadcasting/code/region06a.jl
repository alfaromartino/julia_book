Random.seed!(1234) # hide
x      = rand(100)

foo(x) = x ./ sum(x)

@btime foo($x)    # hide