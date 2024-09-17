x      = [1, 2, 3]
slice  = view(x, x .≥ 2)

slice .= [slice[i] * 10 for i in eachindex(slice)]    # same as 'x[x .≥ 2] = [x[i] * 10 for i in eachindex(x[x .≥ 2])]'
print_asis(x) #hide