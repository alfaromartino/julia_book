Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = sin(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x) #hide