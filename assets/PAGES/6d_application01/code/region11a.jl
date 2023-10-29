targetNonViral = let views = views_per_video, money = money_per_video, threshold = viral_threshold
    new_views = copy(views)
    temp      = @view new_views[new_views .< threshold]
    temp     .= 1.2 .* temp

    allvideos      = trues(length(new_views))
    stats_subset(new_views, money, allvideos)
end
print_compact(targetNonViral) #hide