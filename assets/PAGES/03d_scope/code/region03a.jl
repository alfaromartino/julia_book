function foo(x)
   x      = 2 + x           # redefines the argument
   
   y      = 2 * x
   y      = x + y           # redefines a local variable
end