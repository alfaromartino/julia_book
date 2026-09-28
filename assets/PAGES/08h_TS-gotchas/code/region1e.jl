foo(; x::Int64 = β) = x

β = 1
@code_warntype foo()            #type stable