# characterization of viral videos
viral_threshold = 100
is_viral        = (views_per_video .>= viral_threshold)

# stats
viral_nrvideos = sum(is_viral)
viral_views    = sum(views_per_video[is_viral])
viral_money    = sum(money_per_video[is_viral])