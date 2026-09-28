length_vector      = 3
filling_object     = [1,2]

temp               = fill(filling_object, length_vector)
x                  = vcat(temp...)
print_asis(x) #hide