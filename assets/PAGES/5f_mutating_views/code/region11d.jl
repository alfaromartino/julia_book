x          = [1, 2, 3, 4]

condition  = (x .≥ 1) .&& (x .≤ 2)
slice      = view(x, condition)

slice     .= slice .* 10
print_asis(x) #hide