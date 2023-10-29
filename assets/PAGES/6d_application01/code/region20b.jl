(viral_new_nrvideos, viral_new_views, viral_new_money) = let x = copy(views_per_video)
    temp  = @view x[x .< viral_threshold]
    temp .= temp .* 1.2

    stats_subset(x, money_per_video, is_viral)
end