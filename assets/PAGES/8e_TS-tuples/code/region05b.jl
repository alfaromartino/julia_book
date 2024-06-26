x   = [1, 2, 3]                 # 'Vector{Int64}' has no info on the number of elements


function foo(x)
    tup = Tuple(x)              # 'tup' has type `Tuple{Vararg(Int64)}` (`Vararg` means "variable arguments")

    sum(tup)
end

@code_warntype foo(x)           # type UNSTABLE