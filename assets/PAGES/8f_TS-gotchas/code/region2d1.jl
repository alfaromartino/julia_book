function foo(x)
    β = 0                      # or `beta::Int64 = 0`
    for i in 1:10
        β = β + i
    end

    bar() = x + β              # or `bar(x) = x + beta`

    return bar()
end

@code_warntype foo(1)          # type unstable