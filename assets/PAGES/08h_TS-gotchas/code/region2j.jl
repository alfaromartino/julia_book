function foo(x)
    β            = 0
    inner_foo(x) = x + β 
    
    return inner_foo(x)
end

@code_warntype foo(1)         # type stable