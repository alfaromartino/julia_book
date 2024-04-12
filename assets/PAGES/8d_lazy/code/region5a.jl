using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(100)
weights = rand(100) |> (y ->  y ./ sum(y))

temp(x,weights)           = x * weights
weighted_share(x,weights) = sum(temp.(x,weights))

@btime weighted_share(ref($x), ref($weights)) #hide