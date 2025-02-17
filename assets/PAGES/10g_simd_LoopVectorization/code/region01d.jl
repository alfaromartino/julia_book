Random.seed!(123)       #setting the seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

foo(x)         = @turbo calculation.(x)
    
@ctime foo($x) #hide