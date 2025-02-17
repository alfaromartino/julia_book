Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)

branch1(a,b)   = a * b
branch2(a,b)   = a + b


foo(x,y)       = @. ifelse((x > 0.3) && (y < 0.6) && (x > y), branch1(x,y), branch2(x,y))
@ctime foo($x,$y) #hide