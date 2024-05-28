function foo(x)
    bar() = x + β             # or bar(x) = x + β
    β     = 0

    return bar()
end

@code_warntype foo(1)         # type unstable