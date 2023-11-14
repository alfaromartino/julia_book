using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

our_mean(x) = mapreduce(a -> a/length(x), +, x)
@btime our_mean(ref($x))

our_mean(x) = mapreduce(identity, +, x) / length(x)
@btime our_mean(ref($x))

import Statistics: mean
@btime mean(ref($x))

our_weighted_mean(x,y) = mapreduce(x-> x[1]*x[2], +, zip(x,y))
@btime our_weighted_mean(ref($x), ref($y))

our_weighted_mean(x,y) = reduce(+, map(x-> x[1]*x[2], zip(x,y)))
@btime our_weighted_mean(ref($x), ref($y))

our_weighted_mean(x,y) = reduce(+, map((a,b)-> a*b, x,y))
@btime our_weighted_mean(ref($x), ref($y))

our_weighted_mean(x,y) = mapreduce(splat(*), +, zip(x,y))
@btime our_weighted_mean(ref($x), ref($y))

@btime mean(ref($x), weights(ref($y)))