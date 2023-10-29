stats_audience = ((Symbol(fun), fun(audience_per_video)) for fun in list_functions) |> NamedTuple
print_html2(stats_audience) #hide