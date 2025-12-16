x       = [3, 4, 5]

x[1:2] .= x[1:2] .* 10    # identical output (less performant)
print_asis(x) #hide