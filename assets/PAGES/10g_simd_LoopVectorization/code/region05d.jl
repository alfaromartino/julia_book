Random.seed!(123)       #setting seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a^4

foo(x) = @turbo calculation.(x)    
@ctime foo($x) #hide