foo(; x = γ()) = x

γ() = 1
@code_warntype foo()            #type stable