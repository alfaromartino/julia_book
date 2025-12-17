Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100_000)

foo(x) = max.(@view(x[1:2:length(x)]), 0.5)

@ctime foo($x) #hide