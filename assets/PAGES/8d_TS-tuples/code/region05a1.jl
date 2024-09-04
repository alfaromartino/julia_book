tup = (1, 2, "hello")         # `Tuple{Int64, Int64, String}`


function foo(tup)
    x = Vector(tup)           # 'x' has type `Vector(Any)}`

    sum(x)
end

@code_warntype foo(tup)       # type UNSTABLE