function foo()
    x            = 1
    bar()        = x
    
    return bar()
end

@code_warntype foo()      # type stable