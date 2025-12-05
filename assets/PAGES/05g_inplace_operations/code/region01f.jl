x         = [1, 2, 3]

x[2:end]  = [x[i] * 10 for i in 2:length(x)]
print_asis(x) #hide