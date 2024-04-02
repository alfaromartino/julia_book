x  = [1, 2, 2.5]            # x is converted to Vector{Float64}    


sum(x)          # hide
@code_warntype sum(x)       # type stable