object_with_a_long_name = [-1,2,3]

temp   = object_with_a_long_name
output = [abs(temp[i]) + temp[i] / exp(temp[i]) for i in eachindex(temp)]