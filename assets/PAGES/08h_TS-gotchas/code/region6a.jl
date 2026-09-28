function foo(condition)
    y = condition ?  2.5  :  1
    
    return [y * i for i in 1:100]
end

@code_warntype foo(true)         # type UNSTABLE
@code_warntype foo(false)        # type UNSTABLE