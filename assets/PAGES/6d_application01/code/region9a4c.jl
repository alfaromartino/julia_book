days_to_consider = (1, 10, 25)      # days where the videos were posted
is_day           = in.(eachindex(views_per_video), Ref(days_to_consider))
specific_days    = stats_subset(views_per_video, pay_per_views, is_day)