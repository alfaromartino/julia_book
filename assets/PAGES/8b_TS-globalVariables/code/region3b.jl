const b = [1, 2, 3]
foo()   = sum(b)

foo()          # hide
@code_warntype foo()        # type stable