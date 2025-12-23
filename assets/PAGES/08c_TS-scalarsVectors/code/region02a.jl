foo(x,y)    = x * y

x2::Float64 = 2               # this is converted to `2.0` 
y2          = 0.5

output      = foo(x2,y2)        # type stable: `x` and `y` are `Float64`, so output type is predictable