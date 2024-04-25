x         = [1, 2, 3, 4]


x[3:end]  = [x[i] * 10 for i in 3:length(x)]
print_asis(x) #hide