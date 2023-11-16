# 'temp' modifies 'new_views'
new_views  = copy(views_per_video)
temp       = @view new_views[new_views .≥ viral_threshold]
temp      .= 1.2 .* temp

allvideos      = trues(length(new_views))
targetViral    = stats_subset(new_views, money_per_view, allvideos)
print_compact(targetViral) #hide