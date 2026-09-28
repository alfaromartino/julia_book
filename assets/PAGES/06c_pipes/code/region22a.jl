# just like functions, be careful as you can mutate the global variable   #hide 
x = [2,2,2]

output = let x = x
   x[1] = 0
end
print_asis(x) #hide