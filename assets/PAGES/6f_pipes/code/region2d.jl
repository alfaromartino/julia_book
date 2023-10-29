a = -2

output = let b = a         # 'b' is a local variable having the value of 'a' 
   temp1 = abs(b)
   temp2 = exp(temp1)
   round(temp2)
end