nt     = (a = 1, b = 2, c = "hello")    # `nt` has type @NamedTuple{a::Int64, b::Int64, c::String}

foo(x) = sum(x.a + x.b)

@code_warntype foo(nt)                  # type stable (output is `Int64`)