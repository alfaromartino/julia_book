object_with_a_long_name = [-1,2,3]

output = @pipe object_with_a_long_name |>
               [abs(_[i]) + _[i] / exp(_[i]) for i in eachindex(_)]