foo(; x = β) = x

β = 1
@code_warntype foo()            #type UNSTABLE