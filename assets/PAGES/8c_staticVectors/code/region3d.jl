using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x  = rand(10)
sx = SVector(x...);  mx = MVector(x...)

foo(x) = 10 + 2x +  3x^2

@btime foo.(ref($x));
@btime foo.(ref($sx));
@btime foo.(ref($mx));