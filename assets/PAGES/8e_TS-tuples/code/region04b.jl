tup    = (1, 2.5, "hello")              # `tup` has type `Tuple{Int64, Float64, String}`

foo(x) = sum(x[1:2])

@code_warntype foo(tup)                 # type stable