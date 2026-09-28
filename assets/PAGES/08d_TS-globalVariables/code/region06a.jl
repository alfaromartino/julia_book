Random.seed!(1234)       #setting seed for reproducibility #hide
x           = rand(100_000)


foo(x) = x ./ sum(x)
@ctime foo($x)    #hide