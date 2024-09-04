function foo(condition)
    y = condition ? 1 : 0.5      # either `Int64` or `Float64`
    
    [y * i for i in 1:100]
end

@code_warntype foo(true)         # type UNSTABLE
@code_warntype foo(false)        # type UNSTABLE