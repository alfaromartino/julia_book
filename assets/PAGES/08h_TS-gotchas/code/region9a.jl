function foo(x)
    closure1(x) = x
    closure2(x) = closure1(x)
    
    return closure2(x)
end

@code_warntype foo(1)            # type stable