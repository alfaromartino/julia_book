function foo()
    x            = 1
    x            = 1            # or 'x = x', or 'x = 2'
    
    return x
end

@code_warntype foo()            # type stable