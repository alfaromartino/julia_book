vector = [1, 2, 3.5]                    # type is `Vector{Float64}` (type promotion)

foo(x) = sum(x[1:2])

@code_warntype foo(vector)              # type stable (output returned is `Float64`)