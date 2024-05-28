const a = 5
foo()   = 2 * a

foo()          # hide
@code_warntype foo()        # type stable