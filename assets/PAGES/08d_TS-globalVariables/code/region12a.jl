x3::Int64           = 5
foo()               = 2 * x3

@code_warntype foo()     # type stable