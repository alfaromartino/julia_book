a = -2

output = let a = a         # the 'a' on the left refers to the local variable
   temp1 = abs(a)
   temp2 = exp(temp1)
   round(temp2)
end