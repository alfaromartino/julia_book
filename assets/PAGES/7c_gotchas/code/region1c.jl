foo(; x = α) = x                # or 'x = 1' instead of 'x = α'

const α = 1
@code_warntype foo()            #type stable