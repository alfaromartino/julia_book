tup    = (1, 2, "hello")                # type is `Tuple{Int64, Int64, String}`

foo(x) = sum(x[1:2])

@code_warntype foo(tup)                 # type stable (output is `Int64`)