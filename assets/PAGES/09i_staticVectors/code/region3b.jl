Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(10);   sx = SVector(x...)

foo(x) = sum(2 .* x)

@ctime foo($sx) #hide