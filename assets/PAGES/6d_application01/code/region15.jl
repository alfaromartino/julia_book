function increase_views(views_per_video, viral_threshold, increase_target)
    new_views = copy(views_per_video)

    for i in eachindex(views_per_video)
        (views_per_video[i] < viral_threshold) && (new_views[i] = views_per_video[i] * (1 + increase_target))        
    end

    return new_views
end

new_views = increase_views(views_per_video, viral_threshold, 20 /100)
sum(new_views .>= viral_threshold)