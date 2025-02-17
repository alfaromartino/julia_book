Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = log(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x) #hide