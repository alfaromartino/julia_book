####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used when writing this note.
# It requires having all files (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml) in the same folder.

Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# We use `foo(ref($x))` for more accurate benchmarks of a function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
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
 

 

 

 

 
money_per_video = views_per_video .* money_per_view
 
list_functions = [sum, median, mean, maximum, minimum]
stats_views    = [fun(views_per_video) for fun in list_functions]
 
list_functions = [sum, median, mean, maximum, minimum]

stats_views    = [fun.([views_per_video, money_per_view]) for fun in list_functions]
 
list_functions = [sum, median, mean, maximum, minimum]
stats_views    = [fun(views_per_video) for fun in list_functions]

stats_views = round.(stats_views)
 
list_functions = [sum, median, mean, maximum, minimum]
stats_views    = [fun(views_per_video) for fun in list_functions]

stats_views = round.(stats_views, digits=2)
 
list_functions = [sum, median, mean, maximum, minimum]
stats_views    = [fun(views_per_video) for fun in list_functions]

stats_views = round.(Int64, stats_views)
 
stats_views = NamedTuple((Symbol(fun), fun(views_per_video)) for fun in list_functions)
 

 

 
vector_of_tuples = [(Symbol(fun), fun(views_per_video)) for fun in list_functions]
stats_views      = NamedTuple(vector_of_tuples)
 
############################################################################
#
# 2) Viral videos defined by >100k views. We can use Boolean indices to characterize the videos.
#
############################################################################
 
# characterization of viral videos
viral_threshold = 100
is_viral        = (views_per_video .>= viral_threshold)

# stats
viral_nrvideos = sum(is_viral)
viral_views    = sum(views_per_video[is_viral])
viral_money    = sum(money_per_video[is_viral])
 

 

 

 
# characterization
viral_threshold    = 100
money_above_avg    = 3

is_viral           = (views_per_video .>= viral_threshold)
is_viral_lucrative = (views_per_video .>= viral_threshold) .&& (money_per_view .> money_above_avg)

# stat
proportion_viral_lucrative = sum(is_viral_lucrative) / sum(is_viral) * 100
 
#
function stats_subset(views_per_video, money_per_view, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])

    money_per_video = views_per_video .* money_per_view
    money           = sum(money_per_video[condition])
    
    return (; nrvideos, views, money)
end

viral_threshold = 100
is_viral        = (views_per_video .>= viral_threshold)
viral           = stats_subset(views_per_video, money_per_view, is_viral)
 

 

 
# Base piping
function stats_subset(views_per_video, money_per_view, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])

    money    = (views_per_video .* money_per_view) |> (x -> sum(x[condition]))
    

    return (; nrvideos, views, money)
end

viral_threshold = 100
is_viral        = (views_per_video .>= viral_threshold)
viral           = stats_subset(views_per_video, money_per_view, is_viral)
 
using Pipe
function stats_subset(views_per_video, money_per_view, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])

    money    = @pipe (views_per_video .* money_per_view) |> sum(_[condition])
    

    return (; nrvideos, views, money)
end

viral_threshold = 100
is_viral        = (views_per_video .>= viral_threshold)
viral           = stats_subset(views_per_video, money_per_view, is_viral)
 
function stats_subset(views_per_video, money_per_view, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])
    money    = (views_per_video .* money_per_view) |> (x -> sum(x[condition]))
    
    return (; nrvideos, views, money)
end

#for virals
viral_threshold  = 100
is_viral         = (views_per_video .>= viral_threshold)
viral            = stats_subset(views_per_video, money_per_view, is_viral)

#for non-virals
is_notviral      = .!(is_viral)      # '!' is negating a boolean value, which we then broadcast
notviral         = stats_subset(views_per_video, money_per_view, is_notviral)

# videos created in specific days
days_to_consider = (1, 10, 25)
is_day           = in.(eachindex(views_per_video), Ref(days_to_consider))
specific_days    = stats_subset(views_per_video, money_per_view, is_day)
 

 

 

 
# Working with a subset of values
 
# 'temp' modifies 'new_views'
new_views  = copy(views_per_video)
temp       = @view new_views[new_views .< viral_threshold]
temp      .= 1.2 .* temp

allvideos      = trues(length(new_views))
targetNonViral = stats_subset(new_views, money_per_view, allvideos)
 
# 'temp' modifies 'new_views'
new_views  = copy(views_per_video)
temp       = @view new_views[new_views .≥ viral_threshold]
temp      .= 1.2 .* temp

allvideos      = trues(length(new_views))
targetViral    = stats_subset(new_views, money_per_view, allvideos)
 
targetNonViral = let views = views_per_video, money = money_per_video, threshold = viral_threshold
    new_views = copy(views)
    temp      = @view new_views[new_views .< threshold]
    temp     .= 1.2 .* temp

    allvideos      = trues(length(new_views))
    stats_subset(new_views, money, allvideos)
end
 
targetViral    = let views = views_per_video, money = money_per_video, threshold = viral_threshold
    new_views = copy(views)
    temp      = @view new_views[new_views .≥ threshold]
    temp     .= 1.2 .* temp

    allvideos      = trues(length(new_views))
    stats_subset(new_views, money, allvideos)
end
 
new_views = views_per_video      # it creates an alias, it's a view of the original object!!!

# 'temp' modifies 'views_per_video' -> you lose the original info
temp  = @view new_views[new_views .≥ viral_threshold]
temp .= temp .* 1.2
 
new_views = copy(views_per_video)

# wrong -> not using `temp .= temp .* 1.2`
temp  = @view new_views[new_views .≥ viral_threshold]
temp  = temp .* 1.2             # it creates a new variable 'temp', it does not modify 'new_views'
 
new_views = copy(views_per_video)


temp  = @view new_views[new_views .≥ viral_threshold]
temp .= temp .* 1.2
 
