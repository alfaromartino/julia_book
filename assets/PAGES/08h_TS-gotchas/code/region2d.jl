function foo(x)
    β = 0                      # same conclusion with `beta::Int64 = 0`
    for i in 1:10
        β = β + i
    end

    inner_foo(x) = x + β    

    return inner_foo(x)
end

@code_warntype foo(1)          # type unstable