function foo()
    x::Int64     = 1
    bar()::Int64 = x::Int64
    x            = 1
    
    return bar()
end

@code_warntype foo()            # type unstable