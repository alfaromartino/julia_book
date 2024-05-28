a = -2

output = let a = a         # the 'a' on the left still refers to a local variable
   temp1 = abs(a)
   temp2 = log(temp1)
   round(temp2)
end