foo(; x = β::Int64) = x

β = 1
@code_warntype foo()            #type stable