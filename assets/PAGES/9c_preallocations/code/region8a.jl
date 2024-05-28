using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = sum(2 .* x)                  # 2 .* x implicitly creates a temporary vector  

@btime foo($x) #hide