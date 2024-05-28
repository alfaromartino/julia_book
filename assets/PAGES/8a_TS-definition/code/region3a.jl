function foo(x,y)
    a = (x > y) ?  x  :  y

    a * 2
end

foo(1, 2)           # type stable   -> `a * 2` is always `Int64`