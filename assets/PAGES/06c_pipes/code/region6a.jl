object_with_a_long_name = [-1,2,3]

output = [abs(object_with_a_long_name[i]) + object_with_a_long_name[i] / exp(object_with_a_long_name[i])
          for i in eachindex(object_with_a_long_name)]