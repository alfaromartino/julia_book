foo(; x = ϵ) = x                # or 'x = 1' instead of 'x = ϵ'

ϵ::Int64 = 1
@code_warntype foo()            #type stable