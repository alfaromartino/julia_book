Random.seed!(123)       #setting seed for reproducibility #hide
x              = rand(1_000_000)
y              = rand(1_000_000)


foo(x,y)       = @. ifelse((x>0.3) || (y<0.6) || (x>y), x,y)
@ctime foo($x,$y) #hide