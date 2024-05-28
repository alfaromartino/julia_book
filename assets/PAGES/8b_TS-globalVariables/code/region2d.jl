x  = Vector{Float64}(undef, 10)
x .= 1                      # 1 is converted to 1.0 due to x's type 

sum(x)          # hide
@code_warntype sum(x)       # type stable