x      = [1, 2, 3]          # `x` has type `Vector{Int64}`

foo(x) = sum(x[1:2])        # type stable with this `x`
@ctime sum($x[1:2]) #hide