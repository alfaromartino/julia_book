foo(x,y)    = x * y

x1          = 2
y1          = 0.5

output      = foo(x1,y1)        # type stable: mixing `Int64` and `Float64` results in `Float64`