x  = Vector{Number}(undef, 10)
x .= 1

sum(x)          # hide 
@code_warntype sum(x)       # type unstable