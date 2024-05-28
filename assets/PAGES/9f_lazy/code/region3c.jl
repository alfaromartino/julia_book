using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
# broadcasting eager by default
x = rand(100) ; y = rand(100)

foo(x,y) = sum(2 .* x) + sum(2 .* y) / sum(x .* y)

@btime foo($x, $y) #hide