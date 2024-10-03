Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100); y = rand(100)

foo(x,y) = prod(a -> a[1] * a[2], zip(x,y))        #same output as prod(x .* y)
@btime foo($x, $y) #hide