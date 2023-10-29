new_views = copy(views_per_video) 
new_views |>
     x -> view(x, x .< viral_threshold, :) |>
     x -> 1.2 .* x

viral_new_nrvideos, viral_new_views, viral_new_money = stats_subset(new_views, money_per_video, is_viral)