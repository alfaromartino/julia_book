nt     = (a = 1, b = 2.5, c = "hello")  # `nt` has type @NamedTuple{a::Int64, b::Float64, c::String}

foo(x) = sum(x.a + x.b)

@code_warntype foo(nt)                  # type stable