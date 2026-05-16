x  = Vector{Any}(undef, 2)      # `x` defined with type Vector{Any}
x .= 1

sum(x)          # hide
@code_warntype sum(x)           # type UNSTABLE -> sum considering the possibility of `Any`