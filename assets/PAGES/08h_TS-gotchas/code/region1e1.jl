x = 2
foo(x; y = 2*x) = x * y

@code_warntype foo(x)            #type stable