tup = (1, 2, 3)               # `Tuple{Int64, Int64, Int64}` or just `NTuple{3, Int64}`


function foo(tup)
    x = Vector(tup)           # 'x' has type `Vector(Int64)}`
    sum(x)
end

@code_warntype foo(tup)       # type stable