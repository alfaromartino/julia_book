Random.seed!(123)       #setting seed for reproducibility #hide
nr_days            = 30
score              = rand(nr_days)

performance(score) = score .> 0.5
@ctime performance($score) #hide