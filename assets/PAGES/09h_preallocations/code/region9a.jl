Random.seed!(123)       #setting seed for reproducibility #hide
nr_days            = 30
score              = rand(nr_days)

performance(score) = score .> 0.5

performance_in_a_loop(x) = [sum(foo(x)) for _ in 1:100]
@ctime performance_in_a_loop($x) #hide