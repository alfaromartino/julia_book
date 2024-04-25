x         = [1, 2, 3, 4]


x[x .≥ 3] = [x[i] * 10 for i in 3:length(x)]
print_asis(x) #hide