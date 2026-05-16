using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)
y = rand(100)

@btime sum($x .* $y)