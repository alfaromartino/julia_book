#
function stats_subset(views_per_video, pay_per_views, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])

    pay_per_video = views_per_video .* pay_per_views
    pay           = sum(pay_per_video[condition])
    
    return (; nrvideos, views, pay)
end