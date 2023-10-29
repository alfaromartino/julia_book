list_functions = [sum, median, mean, maximum, minimum]

stats_views    = [fun.([views_per_video, money_per_view]) for fun in list_functions]
print_compact(stats_views) #hide