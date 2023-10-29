using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x  = rand(10)
sx = SVector(x...);  mx = MVector(x...)

foo(x) = sum(a -> 10 + 2a +  3a^2, x)

@btime foo(ref($x));
@btime foo(ref($sx));
@btime foo(ref($mx));