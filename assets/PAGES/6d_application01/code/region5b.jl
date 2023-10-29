stats_audience = [(Symbol(fun), fun(audience_per_video)) for fun in list_functions]
stats_audience = NamedTuple(stats_audience)
print_html2(stats_audience) #hide