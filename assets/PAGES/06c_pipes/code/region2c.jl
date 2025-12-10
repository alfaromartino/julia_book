a      = -2

output = let a = a         # the 'a' on the left of `=` defines a local variable
   temp1 = abs(a)
   temp2 = log(temp1)
   round(temp2)
end
print_asis(output) #hide