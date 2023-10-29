x = collect(-5:5)

output = let x = x
   temp1  = abs.(x)
   temp2  = temp1 ./ sum(temp1)
   round.(temp2, digits=3)
end