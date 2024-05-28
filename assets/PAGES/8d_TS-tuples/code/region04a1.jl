tup    = (1, 2, 3.5)                    # type is `Tuple{Int64, Int64, Float64}`

foo(x) = sum(x[1:2])

@code_warntype foo(tup)                 # type stable (output returned is `Int64`)