# just like functions too, you can't reassign a value through a let block #hide 
x = [2,2,2]

output = let x = x
   x = 0
end
print_asis(x) #hide