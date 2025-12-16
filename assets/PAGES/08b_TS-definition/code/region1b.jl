x = [1, 2, 3]                  # `x` has type `Vector{Int64}`

@btime sum($x[1:2])            # type stable