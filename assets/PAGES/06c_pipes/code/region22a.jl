# just like functions, be careful as you can mutate the global variable   # hide 
# just like functions too, you can't reassign a value through a let block # hide 
x = [2,2,2]

output = let x = x
   x[1] = 0
end