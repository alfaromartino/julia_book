x      = [1, 2, 3, 4]
slice  = view(x, x .≥ 3)

slice .= [i * 10 for i in [3,4]]     # same operation as 'x[x .≥ 3] = [i * 10 for i in [3,4]]'
print_asis(x) #hide