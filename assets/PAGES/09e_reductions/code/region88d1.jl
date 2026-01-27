Random.seed!(123)       #setting seed for reproducibility #hide
x        = rand(100)
y        = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], min, zip(x,y))     #same output as minimum(x .* y)
@ctime foo($x,$y) #hide