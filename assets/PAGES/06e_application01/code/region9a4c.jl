days_to_consider = (1, 10, 25)      # subset of days to be characterized
is_day           = in.(eachindex(visits), Ref(days_to_consider))
specific_days    = stats_subset(visits, payrates, is_day)