function foo()
    bar(x)       = x
    x            = 1    
    
    return bar(x)
end

@code_warntype foo()      # type stable