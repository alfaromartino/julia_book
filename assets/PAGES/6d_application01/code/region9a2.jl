#
function stats_subset(views_per_video, pay_per_views, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])
    
    pay      = (views_per_video .* pay_per_views) |> (x -> sum(x[condition]))
    

    return (; nrvideos, views, pay)
end