# Base piping
function stats_subset(views_per_video, money_per_view, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])

    money    = (views_per_video .* money_per_view) |> (x -> sum(x[condition]))
    

    return (; nrvideos, views, money)
end

viral_threshold = 100
is_viral        = (views_per_video .>= viral_threshold)
viral           = stats_subset(views_per_video, money_per_view, is_viral)