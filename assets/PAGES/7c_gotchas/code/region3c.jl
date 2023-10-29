function foo(x)
    bar() = x + β
    β     = 0

    return bar()
end

@code_warntype foo(1)         # type unstable