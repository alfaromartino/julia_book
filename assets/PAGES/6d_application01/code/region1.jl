using Statistics, Distributions
using Random; Random.seed!(123)

function audience(nr_videos; median_target)
    shape = log(4,5)
    scale = median_target / 2^(1/shape)

    views_per_video = rand(Pareto(shape,scale),  nr_videos)

    return views_per_video
end

nr_videos = 30

views_per_video = audience(nr_videos, median_target = 50)      # in thousands of views
money_per_view  = rand(2:6, nr_videos)                         # per thousands of views