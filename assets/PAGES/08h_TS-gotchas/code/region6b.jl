function foo(::Val{condition}) where condition
    y = condition ?  2.5  :  1
    
    return [y * i for i in 1:100]
end

@code_warntype foo(Val(true))    # type stable
@code_warntype foo(Val(false))   # type stable