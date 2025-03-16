x      = [-2, -1, 1]

slice  = x[x .< 0]          # `slice` is a copy
slice .= 0                  # this does NOT modify `x`
print_asis(x) #hide