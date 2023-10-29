new_views  = copy(views_per_video)
temp       = @view new_views[new_views .< viral_threshold]
temp      .= temp .* 1.2

viral_new_nrvideos, viral_new_views, viral_new_money = stats_subset(new_views, money_per_video, is_viral)