function foo(x)
    y = (x < 0) ?  0  :  x
    
    return [y * i for i in 1:100]
end

@code_warntype foo(1)      # type stable
@code_warntype foo(1.)     # type unstable