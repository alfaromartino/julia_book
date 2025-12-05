tup = (1, 2, 3.5)             # `Tuple{Int64, Int64, Float64}`


function foo(tup)
    x = Vector(tup)           # 'x' has type `Vector(Float64)}`
    sum(x)
end

@code_warntype foo(tup)       # type stable