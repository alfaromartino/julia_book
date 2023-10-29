using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
nr_obs  = 10_000
x       = rand(nr_obs)
indices = randperm(nr_obs)          # indices to be used for subsetting (randomly permuted)

foo(x, indices) = max.(x[indices].^2 , 0.25)

@btime foo(ref($x), ref($indices));