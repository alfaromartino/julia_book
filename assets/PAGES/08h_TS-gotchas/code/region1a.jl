foo(; x) = x

β = 1
@code_warntype foo(x=β)         #type stable