# characterization
viral_threshold = 100
pay_above_avg   = 3

is_viral           = (views_per_video .≥ viral_threshold)
is_viral_lucrative = (views_per_video .≥ viral_threshold) .&& (pay_per_views .> pay_above_avg)

# stat
proportion_viral_lucrative = sum(is_viral_lucrative) / sum(is_viral) * 100
print_compact(proportion_viral_lucrative) #hide