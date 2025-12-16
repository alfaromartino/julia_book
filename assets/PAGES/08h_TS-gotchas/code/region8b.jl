function foo()
    bar()        = x
    x            = 1
    
    return bar()
end

@code_warntype foo()      # type UNSTABLE