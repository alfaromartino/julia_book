x  = Vector{Float64}(undef, 10)
x .= 1                          # 1 is converted to 1.0 to respect x's type defined above

sum(x)          # hide
@code_warntype sum(x)           # type stable