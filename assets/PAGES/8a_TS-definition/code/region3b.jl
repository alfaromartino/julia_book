function foo(x,y)
    a = (x > y) ?  x  :  y

    a * 2
end

foo(1, 2.5)         # type UNSTABLE -> `a * 2` is either `Int64` or `Float64`