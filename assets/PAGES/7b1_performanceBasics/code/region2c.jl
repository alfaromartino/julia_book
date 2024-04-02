x  = Vector{Int64}(undef, 10)
x .= 1

sum(x)          # hide
@code_warntype sum(x)       # type stable