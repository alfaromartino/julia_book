x = [1,2,3]

function foo(x)
    tuple_x = Tuple(x)          

    2 .+ tuple_x
end

@code_warntype foo(x)                   # type UNSTABLE