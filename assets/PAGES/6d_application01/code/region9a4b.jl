viral_threshold  = 100
is_notviral      = .!(is_viral)      # '!' is negating a boolean value, which we then broadcast
notviral         = stats_subset(views_per_video, pay_per_views, is_notviral)