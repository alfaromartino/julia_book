vector_of_tuples = [(Symbol(fun), fun(views_per_video)) for fun in list_functions]
stats_views      = NamedTuple(vector_of_tuples)
print_compact(stats_views) #hide