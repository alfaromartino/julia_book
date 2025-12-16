y::Vector{Float64} = [1, 2, 3]
foo()              = sum(y)

foo()          # type stable
@code_warntype foo() # hide