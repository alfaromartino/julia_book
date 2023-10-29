function foo(condition)
    y = condition ?  2.5  :  1
    
    return [y * i for i in 1:100]
end

@code_warntype foo(true)         # type unstable
@code_warntype foo(false)        # type unstable