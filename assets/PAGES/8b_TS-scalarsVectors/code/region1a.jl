x = [1, 2, "hello"]            # `x` has type `Vector{Any}`

@btime sum($x[1:2])            # type UNSTABLE