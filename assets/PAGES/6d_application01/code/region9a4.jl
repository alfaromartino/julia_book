viral_threshold  = 100
is_viral         = (views_per_video .≥ viral_threshold)
viral            = stats_subset(views_per_video, pay_per_views, is_viral)