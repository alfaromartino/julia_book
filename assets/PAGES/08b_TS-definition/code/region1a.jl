x      = [1, 2, "hello"]    # `x` has type `Vector{Any}`

foo(x) = sum(x[1:2])        # type UNSTABLE with this `x`  
@ctime sum($x[1:2]) #hide