include(joinpath(homedir(), "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
# using Statistics, Distributions, Random, Pipe
 
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

    views_per_video = rand(Pareto(shape,scale),  nr_videos)

    return views_per_video
end

nr_videos = 30

views_per_video = audience(nr_videos, median_target = 50)      # in thousands of views
pay_per_views   = rand(2:6, nr_videos)                         # per thousands of views
 
print_compact(nr_videos) #hide
 
print_compact(views_per_video) #hide
 
print_compact(pay_per_views) #hide
 
pay_per_video = views_per_video .* pay_per_views
print_compact(pay_per_video) #hide
 
############################################################################
#
# SOME STATISTICS
#    
############################################################################
 
top_earnings = sort(pay_per_video, rev=true)[1:3]
top_earnings |> print_compact #hide
 
indices      = sortperm(pay_per_video, rev=true)[1:3]

sorted_pay   = pay_per_views[indices]
print_compact(sorted_pay) #hide
 
indices      = sortperm(pay_per_video, rev=true)[1:3]

sorted_views = views_per_video[indices]
print_compact(sorted_views) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
range_pay_per_views  = unique(pay_per_views) |> sort
range_pay_per_views |> print_compact #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using StatsBase
counts_pay_per_views = countmap(pay_per_views) |> sort
counts_pay_per_views |> print_compact #hide
 
############################################################################
#
# BOOLEAN INDICES
# (to characterize viral videos defined by >100k views)
#    
############################################################################
 
# characterization of viral videos
viral_threshold = 100
is_viral        = (views_per_video .≥ viral_threshold)

# stats
viral_nrvideos = sum(is_viral)
viral_views    = sum(views_per_video[is_viral])
viral_pay      = sum(pay_per_video[is_viral])
 
print_compact(viral_nrvideos) #hide
 
print_compact(viral_views) #hide
 
print_compact(viral_pay) #hide
 
# characterization
viral_threshold = 100
pay_above_avg   = 3

is_viral           = (views_per_video .≥ viral_threshold)
is_viral_lucrative = (views_per_video .≥ viral_threshold) .&& (pay_per_views .> pay_above_avg)

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
function stats_subset(views_per_video, pay_per_views, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])

    pay_per_video = views_per_video .* pay_per_views
    pay           = sum(pay_per_video[condition])
    
    return (; nrvideos, views, pay)
end
 
# <space_to_be_deleted>
 
using Pipe
function stats_subset(views_per_video, pay_per_views, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])
    
    pay      = @pipe (views_per_video .* pay_per_views) |> sum(_[condition])
    

    return (; nrvideos, views, pay)
end
 
viral_threshold  = 100
is_viral         = (views_per_video .≥ viral_threshold)
viral            = stats_subset(views_per_video, pay_per_views, is_viral)
 
print_compact(viral) #hide
 
viral_threshold  = 100
is_notviral      = .!(is_viral)      # '!' is negating a boolean value, which we then broadcast
notviral         = stats_subset(views_per_video, pay_per_views, is_notviral)
 
print_compact(notviral) #hide
 
days_to_consider = (1, 10, 25)      # days when the videos were posted
is_day           = in.(eachindex(views_per_video), Ref(days_to_consider))
specific_days    = stats_subset(views_per_video, pay_per_views, is_day)
 
print_compact(specific_days) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
# SUBSETTING DATA
#    
############################################################################
 
# 'temp' modifies 'new_views'
new_views       = copy(views_per_video)
temp            = @view new_views[new_views .< viral_threshold]
temp           .= 1.2 .* temp

allvideos       = trues(length(new_views))
targetNonViral  = stats_subset(new_views, pay_per_views, allvideos)
print_compact(targetNonViral) #hide
 
# 'temp' modifies 'new_views'
new_views       = copy(views_per_video)
temp            = @view new_views[new_views .≥ viral_threshold]
temp           .= 1.2 .* temp

allvideos       = trues(length(new_views))
targetViral     = stats_subset(new_views, pay_per_views, allvideos)
print_compact(targetViral) #hide
 
targetNonViral = let views = views_per_video, pay = pay_per_video, threshold = viral_threshold
    new_views = copy(views)
    temp      = @view new_views[new_views .< threshold]
    temp     .= 1.2 .* temp

    allvideos      = trues(length(new_views))
    stats_subset(new_views, pay, allvideos)
end
print_compact(targetNonViral) #hide
 
targetViral    = let views = views_per_video, pay = pay_per_video, threshold = viral_threshold
    new_views = copy(views)
    temp      = @view new_views[new_views .≥ threshold]
    temp     .= 1.2 .* temp

    allvideos      = trues(length(new_views))
    stats_subset(new_views, pay, allvideos)
end
print_compact(targetViral) #hide
 
############
# REMARK: WRONG USES
# only the first one is right
############
 
new_views = copy(views_per_video)


temp  = @view new_views[new_views .≥ viral_threshold]
temp .= temp .* 1.2
 
new_views = views_per_video      # it creates an alias, it's a view of the original object!!!

# 'temp' modifies 'views_per_video' -> you lose the original info
temp  = @view new_views[new_views .≥ viral_threshold]
temp .= temp .* 1.2
 
new_views = copy(views_per_video)

# wrong -> not using `temp .= temp .* 1.2`
temp  = @view new_views[new_views .≥ viral_threshold]
temp  = temp .* 1.2             # it creates a new variable 'temp', it does not modify 'new_views'
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
# BROADCASTING OVER A LIST OF FUNCTIONS (OPTIONAL)
#    
############################################################################
 
describe(views_per_video)
print(describe(views_per_video)) #hide
 
list_functions   = [sum, median, mean, maximum, minimum]

stats_views      = [fun(views_per_video) for fun in list_functions]
print_compact(stats_views) #hide
 
list_functions   = [sum, median, mean, maximum, minimum]

stats_views      = [fun.([views_per_video, pay_per_views]) for fun in list_functions]
print_compact(stats_views) #hide
 
stats_views      = NamedTuple((Symbol(fun), fun(views_per_video)) for fun in list_functions)
print_compact(stats_views) #hide
 
print_compact(stats_views.mean) #hide
 
print_compact(stats_views[:median]) #hide
 
vector_of_tuples = [(Symbol(fun), fun(views_per_video)) for fun in list_functions]
stats_views      = NamedTuple(vector_of_tuples)
print_compact(stats_views) #hide
 
