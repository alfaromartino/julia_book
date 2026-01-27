Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(1_000_000)

foo(x) = @. x / 2 + x^2 / 3
    
@ctime foo($x) #hide