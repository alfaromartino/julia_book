viral_threshold  = 100
is_notviral      = .!(is_viral)      # '!' is negating a boolean value, which we then broadcast
notviral         = stats_subset(visits, payrates, is_notviral)