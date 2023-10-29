x = 2

function foo() 
    y = 2 * x 
    z = log(y)

    return z
end

foo()   # hide
@code_warntype foo() # type unstable