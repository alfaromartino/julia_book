Random.seed!(123)       #setting seed for reproducibility #hide
x        = rand(100)
y        = rand(100)

foo(x,y) = prod(a -> a[1] * a[2], zip(x,y))        #same output as prod(x .* y)
@ctime foo($x, $y) #hide