function foo()
    β            = 1
    β            = 1      # or `β = β`, or `β = 2`
    bar(β)       = β    

    return bar(β)
end

@code_warntype foo()      # type stable