function foo(x)
    inner_foo(x) = x + β
    β            = 0

    return inner_foo(x)
end

@code_warntype foo(1)         # type unstable