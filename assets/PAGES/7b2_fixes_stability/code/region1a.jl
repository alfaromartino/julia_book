x = 2

function foo(x) 
    y = 2 * x 
    z = log(y)

    return z
end

# foo(x)  # hide
@code_warntype foo(x)  # type stable