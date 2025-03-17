x      = [1, 2, 3]

slice  = view(x, x .≥ 2)
slice .= slice .* 10            # same as 'x[x .≥ 2] = x[x .≥ 2] .* 10'
print_asis(x) #hide