Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

foo(x) = x ./ sum(x)

@ctime foo($x)    #hide