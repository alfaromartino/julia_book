function foo()
    x            = 1
    x            = 1            # or 'x = x', or 'x = 2'
    bar(x)       = x
    
    return bar(x)
end

@code_warntype foo()            # type stable