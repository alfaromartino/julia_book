x       = [1,2,3]
tuple_x = Tuple(x)

function foo(x)


    2 .+ x
end

@code_warntype foo(tuple_x)             # type stable