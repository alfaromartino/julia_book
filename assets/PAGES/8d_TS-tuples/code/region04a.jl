tup    = (1, 2.5, 3)                    # `tup` has type `Tuple{Int64, Int64, Int64}` or just `NTuple{3, Int64}`

foo(x) = sum(x[1:2])

@code_warntype foo(tup)                 # type stable (type promotion of `Int64` and `Float64` to `Float64`)