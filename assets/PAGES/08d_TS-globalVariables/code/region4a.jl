x::Int64 = 5
foo()    = 2 * x

foo()          # type stable
@code_warntype foo() # hide