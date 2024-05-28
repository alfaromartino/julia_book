nt     = (a = 1, b = 2, c = 3.5)        # `nt` has type @NamedTuple{a::Int64, b::Int64, c::Float64}

foo(x) = sum(x.a + x.b)

@code_warntype foo(nt)                  # type stable (output is `Int64`)