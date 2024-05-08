x  = Vector{Number}(undef, 2)   # `x` defined with type Vector{Number}
x .= [1, 1.0]                   # `x` is type promoted to [1.0, 1.0] but still Vector{Number}

sum(x)          # hide 
@code_warntype sum(x)           # type unstable -> sum considering the possibility of all numeric types