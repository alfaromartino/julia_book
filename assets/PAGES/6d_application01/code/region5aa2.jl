list_functions = [sum, median, mean, maximum, minimum]
stats_views    = [fun(views_per_video) for fun in list_functions]

stats_views = round.(stats_views)
print_asis(stats_views) #hide