Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)
condition(a,b) = (a > 0.3) || (b < 0.6) || (a > b)

foo(x,y)       = @. ifelse(condition(x,y), x,y)
@ctime foo($x,$y) #hide