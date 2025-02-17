function foo(x)
    β     = 0
    bar() = x + β
    
    return bar()
end

@code_warntype foo(1)         # type stable