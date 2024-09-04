function foo(x)
    closure2(x, closure1) = closure1(x)
    closure1(x)           = x
    
    return closure2(x, closure1)
end

@code_warntype foo(1)            # type stable