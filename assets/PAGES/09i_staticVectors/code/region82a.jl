Random.seed!(123)       #setting seed for reproducibility #hide
_size  = 2_000
vector = rand(_size)
tuple  = Tuple(vector)

foo(x) = sum(x .* x)