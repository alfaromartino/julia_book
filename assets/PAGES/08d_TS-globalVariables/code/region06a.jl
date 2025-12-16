using Random; Random.seed!(1234) # hide
x           = rand(100_000)


foo(x) = x ./ sum(x)

@btime foo($x)    # hide