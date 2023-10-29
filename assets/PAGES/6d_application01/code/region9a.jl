function stats_subset(views_per_video, money_per_view, condition)    
    nrvideos        = sum(condition)
    views           = sum(views_per_video[condition])

    money_per_video = views_per_video .* money_per_view
    money           = sum(money_per_video[condition])
    
    return nrvideos, views, money
end

viral_nrvideos, viral_views, viral_money = stats_subset(views_per_video, money_per_video, is_viral)