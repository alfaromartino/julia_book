function stats_subset(views_per_video, money_per_view, condition)
    nrvideos = sum(condition)
    views    = sum(views_per_video[condition])
    money    = (views_per_video .* money_per_view) |> (x -> sum(x[condition]))
    
    return (; nrvideos, views, money)
end

#for virals
viral_threshold  = 100
is_viral         = (views_per_video .>= viral_threshold)
viral            = stats_subset(views_per_video, money_per_view, is_viral)

#for non-virals
is_notviral      = .!(is_viral)      # '!' is negating a boolean value, which we then broadcast
notviral         = stats_subset(views_per_video, money_per_view, is_notviral)

# videos created in the first 15 days of the month
days_to_consider = 1:15
is_firstdays     = in.(eachindex(views_per_video), Ref(days_to_consider))
firstdays        = stats_subset(views_per_video, money_per_view, is_firstdays)