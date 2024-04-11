using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = tuple(rand(100)...)
y = tuple(rand(100)...)

@btime sum($x .* $y)