Random.seed!(123)       #setting seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = exp(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x) #hide