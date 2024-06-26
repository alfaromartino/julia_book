using Random; Random.seed!(1234) # hide
x           = rand(100_000)
const sum_x = sum(x)

foo(x) = x ./ sum_x

@btime foo($x)    # hide