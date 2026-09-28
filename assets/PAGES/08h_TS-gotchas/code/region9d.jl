function foo(x)
    closure2(x) = closure1(x)    
    
    return closure2(x)
end

closure1(x) = x

@code_warntype foo(1)            # type stable