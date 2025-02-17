x = collect(-5:5)

output = let x = x
   temp1  = abs.(x)
   temp2  = exp.(temp1)
   sum(temp2)
end