function foo()
    bar()::Int64 = x::Int64
    x::Int64     = 1
    x            = 1
    
    return bar()
end

@code_warntype foo()            # type UNSTABLE