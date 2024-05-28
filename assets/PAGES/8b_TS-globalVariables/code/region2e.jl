x  = [1, 2, "hello"]    # x has type "Any"


sum(x[1:2])     # hide
@code_warntype sum(x[1:2])  # type unstable