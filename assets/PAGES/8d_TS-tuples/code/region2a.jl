x  = [1, 2, "hello"]            # `x` has type Vector{Any}, due to the combination of numbers and strings


sum(x[1:2])     # hide
@code_warntype sum(x[1:2])      # type UNSTABLE -> sum considering the possibility of `Any`