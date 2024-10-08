####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate results, we benchmark code through functions and interpolate each argument.
    # this means that benchmarking a function `foo(x)` makes use of `foo($x)`
using BenchmarkTools

# The following defines the macro `@fast_btime foo($x)`
    # `@fast_btime` is equivalent to `@btime` but substantially faster
    # if you want to use it, you should replace `@btime` with `@fast_btime`
    # by default, if `@fast_btime` doesn't provide allocations, it means there are none
using Chairmarks
macro fast_btime(ex)
    return quote
        display(@b $ex)
    end
end

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Random, StatsBase, Distributions , Pipe
 
############################################################################
#
#       MOCK DATASET
#
############################################################################
 
using StatsBase, Distributions
using Random; Random.seed!(1234)

function audience(nr_videos; median_target)
    shape = log(4,5)
    scale = median_target / 2^(1/shape)

    visits = rand(Pareto(shape,scale),  nr_videos)

    return visits
end

nr_videos = 30

visits   = audience(nr_videos, median_target = 50)      # in thousands of visits
payrates = rand(2:6, nr_videos)                         # per thousands of visits
 
earnings = visits .* payrates
 
############################################################################
#
# SOME STATISTICS
#    
############################################################################
 
top_earnings    = sort(earnings, rev=true)[1:3]
top_earnings |> print_compact
 
indices         = sortperm(earnings, rev=true)[1:3]

sorted_payrates = payrates[indices]
 
indices         = sortperm(earnings, rev=true)[1:3]

sorted_visits   = visits[indices]
 



range_payrates  = unique(payrates) |> sort
range_payrates |> print_compact
 


using StatsBase
occurrences_payrates = countmap(payrates) |> sort
occurrences_payrates |> print_compact
 
############################################################################
#
# BOOLEAN INDICES
# (to characterize viral videos defined by >100k visits)
#    
############################################################################
 
# characterization of viral videos
viral_threshold = 100
is_viral        = (visits .≥ viral_threshold)

# stats
viral_nrvideos  = sum(is_viral)
viral_visits    = sum(visits[is_viral])
viral_revenue   = sum(earnings[is_viral])
 
# characterization
viral_threshold    = 100
payrates_above_avg = 3

is_viral           = (visits .≥ viral_threshold)
is_viral_lucrative = (visits .≥ viral_threshold) .&& (payrates .> payrates_above_avg)

# stat
proportion_viral_lucrative = sum(is_viral_lucrative) / sum(is_viral) * 100
 
rounded_proportion = round(proportion_viral_lucrative)
 
rounded_proportion = round(proportion_viral_lucrative, digits=1)
 
rounded_proportion = round(Int, proportion_viral_lucrative)
 


############################################################################
#
# FUNCTIONS TO REPRESENT TASKS
# 
############################################################################
 
#
function stats_subset(visits, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(visits[condition])
    
    earnings = visits .* payrates
    revenue  = sum(earnings[condition])
    
    return (; nrvideos, audience, revenue)
end
 


using Pipe
function stats_subset(visits, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(visits[condition])
    
    
    revenue  = @pipe (visits .* payrates) |> x -> sum(x[condition])
    
    return (; nrvideos, audience, revenue)
end
 


using Pipe
function stats_subset(visits, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(visits[condition])
    
    
    revenue  = @pipe (visits .* payrates) |> sum(_[condition])
    
    return (; nrvideos, audience, revenue)
end
 
viral_threshold  = 100
is_viral         = (visits .≥ viral_threshold)
viral            = stats_subset(visits, payrates, is_viral)
 
viral_threshold  = 100
is_notviral      = .!(is_viral)      # '!' is negating a boolean value and we broadcast it
notviral         = stats_subset(visits, payrates, is_notviral)
 
days_to_consider = (1, 10, 25)      # days when the videos were posted
is_day           = in.(eachindex(visits), Ref(days_to_consider))
specific_days    = stats_subset(visits, payrates, is_day)
 


############################################################################
#
# SUBSETTING DATA
#    
############################################################################
 
# 'temp' modifies 'new_visits'
new_visits      = copy(visits)
temp            = @view new_visits[new_visits .< viral_threshold]
temp           .= 1.2 .* temp

allvideos       = trues(length(new_visits))
targetNonViral  = stats_subset(new_visits, payrates, allvideos)
 
# 'temp' modifies 'new_visits'
new_visits      = copy(visits)
temp            = @view new_visits[new_visits .≥ viral_threshold]
temp           .= 1.2 .* temp

allvideos       = trues(length(new_visits))
targetViral     = stats_subset(new_visits, payrates, allvideos)
 
targetNonViral = let visits = visits, payrates = payrates, threshold = viral_threshold
    new_visits = copy(visits)
    temp       = @view new_visits[new_visits .< threshold]
    temp      .= 1.2 .* temp

    allvideos  = trues(length(new_visits))
    stats_subset(new_visits, payrates, allvideos)
end
 
targetViral    = let visits = visits, payrates = payrates, threshold = viral_threshold
    new_visits = copy(visits)
    temp       = @view new_visits[new_visits .≥ threshold]
    temp      .= 1.2 .* temp

    allvideos  = trues(length(new_visits))
    stats_subset(new_visits, payrates, allvideos)
end
 
############
# REMARK: WRONG USES
# only the first one is right
############
 
new_visits = copy(visits)


temp  = @view new_visits[new_visits .≥ viral_threshold]
temp .= temp .* 1.2
 
new_visits = visits     # it creates an alias, it's a view of the original object!!!

# 'temp' modifies 'visits' -> you lose the original info
temp  = @view new_visits[new_visits .≥ viral_threshold]
temp .= temp .* 1.2
 
new_visits = copy(visits)

# wrong -> not using `temp .= temp .* 1.2`
temp  = @view new_visits[new_visits .≥ viral_threshold]
temp  = temp .* 1.2     # it creates a new variable 'temp', it does not modify 'new_visits'
 


############################################################################
#
# BROADCASTING OVER A LIST OF FUNCTIONS (OPTIONAL)
#    
############################################################################
 
describe(visits)
print(describe(visits))
 



list_functions = [sum, median, mean, maximum, minimum]

stats_visits   = [fun(visits) for fun in list_functions]
 


list_functions = [sum, median, mean, maximum, minimum]

stats_various  = [fun.([visits, payrates]) for fun in list_functions]
 



stats_visits   = NamedTuple((Symbol(fun), fun(visits)) for fun in list_functions)
 



vector_of_tuples = [(Symbol(fun), fun(visits)) for fun in list_functions]
stats_visits     = NamedTuple(vector_of_tuples)
 
