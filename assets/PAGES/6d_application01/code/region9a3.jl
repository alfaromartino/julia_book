using Pipe
function stats_subset(views_per_video, pay_per_views, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])
    
    pay      = @pipe (views_per_video .* pay_per_views) |> sum(_[condition])
    

    return (; nrvideos, views, pay)
end