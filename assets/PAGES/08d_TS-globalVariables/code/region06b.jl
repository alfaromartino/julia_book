Random.seed!(1234)       #setting seed for reproducibility #hide
x           = rand(100_000)
const sum_x = sum(x)

foo(x) = x ./ sum_x
@ctime foo($x)    #hide