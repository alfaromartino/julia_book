x   = [1, 2, "hello"]           # 'Vector{Any}' has no info on each individual type


function foo(x)
    tup = Tuple(x)              # 'tup' has type `Tuple`

    sum(tup[1:2])
end

@code_warntype foo(x)           # type UNSTABLE