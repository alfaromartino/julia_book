####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
# necessary packages for this file
using Random, StatsBase, Distributions, Pipe
 
############################################################################
#
#       MOCK DATASET
#
############################################################################
 
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
 
println(nr_videos)
 
println(viewers)
 
println(payrates)
 
earnings = viewers .* payrates
println(earnings)
 
############################################################################
#
# SOME STATISTICS
#    
############################################################################
 
top_earnings    = sort(earnings, rev=true)[1:3]
top_earnings |> println
 
indices         = sortperm(earnings, rev=true)[1:3]

sorted_payrates = payrates[indices]
println(sorted_payrates)
 
indices         = sortperm(earnings, rev=true)[1:3]

sorted_viewers  = viewers[indices]
println(sorted_viewers)
 



range_payrates  = unique(payrates) |> sort
range_payrates |> println
 



using StatsBase
occurrences_payrates = countmap(payrates) |> sort
occurrences_payrates |> println
 
############################################################################
#
# BOOLEAN INDICES
# (to characterize viral videos defined by >100k viewers)
#    
############################################################################
 
# characterization of viral videos
viral_threshold = 100
is_viral        = (viewers .≥ viral_threshold)

# stats
viral_nrvideos  = sum(is_viral)
viral_viewers   = sum(viewers[is_viral])
viral_revenue   = sum(earnings[is_viral])
 
println(viral_nrvideos)
 
println(viral_viewers)
 
println(viral_revenue)
 
# characterization
viral_threshold    = 100
payrates_above_avg = 3

is_viral           = (viewers .≥ viral_threshold)
is_viral_lucrative = (viewers .≥ viral_threshold) .&& (payrates .> payrates_above_avg)

# stat
proportion_viral_lucrative = sum(is_viral_lucrative) / sum(is_viral) * 100
println(proportion_viral_lucrative)
 
rounded_proportion = round(proportion_viral_lucrative)
println(rounded_proportion)
 
rounded_proportion = round(proportion_viral_lucrative, digits=1)
println(rounded_proportion)
 
rounded_proportion = round(Int64, proportion_viral_lucrative)
println(rounded_proportion)
 



############################################################################
#
# FUNCTIONS TO REPRESENT TASKS
# 
############################################################################
 
#
function stats_subset(viewers, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(viewers[condition])
    
    earnings = viewers .* payrates
    revenue  = sum(earnings[condition])
    
    return (; nrvideos, audience, revenue)
end
 



using Pipe
function stats_subset(viewers, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(viewers[condition])
    
    
    revenue  = @pipe (viewers .* payrates) |> x -> sum(x[condition])
    
    return (; nrvideos, audience, revenue)
end
 



using Pipe
function stats_subset(viewers, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(viewers[condition])
    
    
    revenue  = @pipe (viewers .* payrates) |> sum(_[condition])
    
    return (; nrvideos, audience, revenue)
end
 
viral_threshold  = 100
is_viral         = (viewers .≥ viral_threshold)
viral            = stats_subset(viewers, payrates, is_viral)
 
println(viral)
 
viral_threshold  = 100
is_notviral      = .!(is_viral)      # '!' is negating a boolean value and we broadcast it
notviral         = stats_subset(viewers, payrates, is_notviral)
 
println(notviral)
 
days_to_consider = (1, 10, 25)      # subset of days to be characterized
is_day           = in.(eachindex(viewers), Ref(days_to_consider))
specific_days    = stats_subset(viewers, payrates, is_day)
 
println(specific_days)
 



############################################################################
#
# SUBSETTING DATA
#    
############################################################################
 
# 'temp' modifies 'new_viewers'
new_viewers     = copy(viewers)
temp            = @view new_viewers[new_viewers .< viral_threshold]
temp           .= 1.2 .* temp

allvideos       = trues(length(new_viewers))
targetNonViral  = stats_subset(new_viewers, payrates, allvideos)
println(targetNonViral)
 
# 'temp' modifies 'new_viewers'
new_viewers     = copy(viewers)
temp            = @view new_viewers[new_viewers .≥ viral_threshold]
temp           .= 1.2 .* temp

allvideos       = trues(length(new_viewers))
targetViral     = stats_subset(new_viewers, payrates, allvideos)
println(targetViral)
 
targetNonViral = let viewers = viewers, payrates = payrates, threshold = viral_threshold
    new_viewers = copy(viewers)
    temp        = @view new_viewers[new_viewers .< threshold]
    temp       .= 1.2 .* temp

    allvideos  = trues(length(new_viewers))
    stats_subset(new_viewers, payrates, allvideos)
end
println(targetNonViral)
 
targetViral    = let viewers = viewers, payrates = payrates, threshold = viral_threshold
    new_viewers = copy(viewers)
    temp        = @view new_viewers[new_viewers .≥ threshold]
    temp       .= 1.2 .* temp

    allvideos  = trues(length(new_viewers))
    stats_subset(new_viewers, payrates, allvideos)
end
println(targetViral)
 
############
# REMARK: WRONG USES
# only the first one is right
############
 
new_viewers = copy(viewers)


temp  = @view new_viewers[new_viewers .≥ viral_threshold]
temp .= temp .* 1.2
 
new_viewers = viewers     # it creates an alias, it's a view of the original object!!!

# 'temp' modifies 'viewers' -> you lose the original info
temp  = @view new_viewers[new_viewers .≥ viral_threshold]
temp .= temp .* 1.2
 
new_viewers = copy(viewers)

# wrong -> not using `temp .= temp .* 1.2`
temp  = @view new_viewers[new_viewers .≥ viral_threshold]
temp  = temp .* 1.2     # it creates a new variable 'temp', it does not modify 'new_viewers'
 



############################################################################
#
# BROADCASTING OVER A LIST OF FUNCTIONS (OPTIONAL)
#    
############################################################################
 
describe(viewers)
print(describe(viewers))
 



list_functions = [sum, median, mean, maximum, minimum]

stats_viewers  = [fun(viewers) for fun in list_functions]
println(stats_viewers)
 



list_functions = [sum, median, mean, maximum, minimum]

stats_various  = [fun.([viewers, payrates]) for fun in list_functions]
println(stats_various)
 



stats_viewers  = NamedTuple((Symbol(fun), fun(viewers)) for fun in list_functions)
println(stats_viewers)
 
println(stats_viewers.mean)
 
println(stats_viewers[:median])
 



vector_of_tuples = [(Symbol(fun), fun(viewers)) for fun in list_functions]
stats_viewers    = NamedTuple(vector_of_tuples)
println(stats_viewers)
 
