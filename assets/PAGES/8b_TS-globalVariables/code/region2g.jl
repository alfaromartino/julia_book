x  = [1.0, 2, 2.0]          # x is converted to Vector{Float64}


sum(x)          # hide
@code_warntype sum(x)       # type stable