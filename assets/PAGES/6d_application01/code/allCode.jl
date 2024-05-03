include(joinpath(homedir(), "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using StatsBase, Distributions, Random, Pipe
 
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
 
print_compact(nr_videos) #hide
 
print_compact(visits) #hide
 
print_compact(payrates) #hide
 
earnings = visits .* payrates
print_compact(earnings) #hide
 
############################################################################
#
# SOME STATISTICS
#    
############################################################################
 
top_earnings    = sort(earnings, rev=true)[1:3]
top_earnings |> print_compact #hide
 
indices         = sortperm(earnings, rev=true)[1:3]

sorted_payrates = payrates[indices]
print_compact(sorted_payrates) #hide
 
indices         = sortperm(earnings, rev=true)[1:3]

sorted_visits   = visits[indices]
print_compact(sorted_visits) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
range_payrates  = unique(payrates) |> sort
range_payrates |> print_compact #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using StatsBase
occurrences_payrates = countmap(payrates) |> sort
occurrences_payrates |> print_compact #hide
 
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
 
print_compact(viral_nrvideos) #hide
 
print_compact(viral_visits) #hide
 
print_compact(viral_payrates) #hide
 
# characterization
viral_threshold    = 100
payrates_above_avg = 3

is_viral           = (visits .≥ viral_threshold)
is_viral_lucrative = (visits .≥ viral_threshold) .&& (payrates .> payrates_above_avg)

# stat
proportion_viral_lucrative = sum(is_viral_lucrative) / sum(is_viral) * 100
print_compact(proportion_viral_lucrative) #hide
 
rounded_proportion = round(proportion_viral_lucrative)
print_asis(rounded_proportion) #hide
 
rounded_proportion = round(proportion_viral_lucrative, digits=1)
print_asis(rounded_proportion) #hide
 
rounded_proportion = round(Int, proportion_viral_lucrative)
print_asis(rounded_proportion) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
# <space_to_be_deleted>
 
using Pipe
function stats_subset(visits, payrates, condition)
    nrvideos = sum(condition)
    audience = sum(visits[condition])
    
    
    revenue  = @pipe (visits .* payrates) |> x -> sum(x[condition])
    
    return (; nrvideos, audience, revenue)
end
 
# <space_to_be_deleted>
 
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
 
print_compact(viral) #hide
 
viral_threshold  = 100
is_notviral      = .!(is_viral)      # '!' is negating a boolean value and we broadcast it
notviral         = stats_subset(visits, payrates, is_notviral)
 
print_compact(notviral) #hide
 
days_to_consider = (1, 10, 25)      # days when the videos were posted
is_day           = in.(eachindex(visits), Ref(days_to_consider))
specific_days    = stats_subset(visits, payrates, is_day)
 
print_compact(specific_days) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
print_compact(targetNonViral) #hide
 
# 'temp' modifies 'new_visits'
new_visits      = copy(visits)
temp            = @view new_visits[new_visits .≥ viral_threshold]
temp           .= 1.2 .* temp

allvideos       = trues(length(new_visits))
targetViral     = stats_subset(new_visits, payrates, allvideos)
print_compact(targetViral) #hide
 
targetNonViral = let visits = visits, payrates = payrates, threshold = viral_threshold
    new_visits = copy(visits)
    temp       = @view new_visits[new_visits .< threshold]
    temp      .= 1.2 .* temp

    allvideos  = trues(length(new_visits))
    stats_subset(new_visits, payrates, allvideos)
end
print_compact(targetNonViral) #hide
 
targetViral    = let visits = visits, payrates = payrates, threshold = viral_threshold
    new_visits = copy(visits)
    temp       = @view new_visits[new_visits .≥ threshold]
    temp      .= 1.2 .* temp

    allvideos  = trues(length(new_visits))
    stats_subset(new_visits, payrates, allvideos)
end
print_compact(targetViral) #hide
 
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
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
# BROADCASTING OVER A LIST OF FUNCTIONS (OPTIONAL)
#    
############################################################################
 
describe(visits)
print(describe(visits)) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
list_functions = [sum, median, mean, maximum, minimum]

stats_visits   = [fun(visits) for fun in list_functions]
print_compact(stats_visits) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
list_functions = [sum, median, mean, maximum, minimum]

stats_various  = [fun.([visits, payrates]) for fun in list_functions]
print_compact(stats_various) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
stats_visits   = NamedTuple((Symbol(fun), fun(visits)) for fun in list_functions)
print_compact(stats_visits) #hide
 
print_compact(stats_visits.mean) #hide
 
print_compact(stats_visits[:median]) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
vector_of_tuples = [(Symbol(fun), fun(visits)) for fun in list_functions]
stats_visits     = NamedTuple(vector_of_tuples)
print_compact(stats_visits) #hide
 
