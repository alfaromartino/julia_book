x  = [1, 2, 2.5]                # x has type Vector{Float64} (converted by the so-called 'type promotion')


sum(x)          # hide
@code_warntype sum(x)           # type stable