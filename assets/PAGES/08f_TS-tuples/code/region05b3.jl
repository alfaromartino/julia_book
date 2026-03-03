x   = [1 ,2 ,3]            # 'Vector{Int64}' identifies `Int64`, but no info on the number of elements

function foo(x)
    tup   = Tuple(x)       # type `Tuple{Vararg(Int64)}` (`Vararg` is "variable number of arguments")
    

    sum(tup)
end

@code_warntype foo(x)      # type UNSTABLE