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
viral           = stats_subset(views_per_video, money_per_video, is_viral)
print_compact(viral) #hide