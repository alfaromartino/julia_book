using StatsBase, Distributions
using Random; Random.seed!(1234)

function audience(nr_videos; median_target)
    shape   = log(4,5)
    scale   = median_target / 2^(1/shape)
    
    viewers = rand(Pareto(shape,scale),  nr_videos)

    return viewers
end

nr_videos = 30

viewers  = audience(nr_videos, median_target = 50)      # in thousands of viewers
payrates = rand(2:6, nr_videos)                         # per thousands of viewers