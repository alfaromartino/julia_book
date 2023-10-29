function foo()
    x            = 1
    x            = 1            # or 'x = x', or 'x = 2'
    bar()        = x
        
    return bar()
end

@code_warntype foo()            # type unstable