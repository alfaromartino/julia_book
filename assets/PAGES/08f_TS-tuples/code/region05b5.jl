x   = [1 ,2 ,3]            # 'Vector{Int64}' identifies `Int64`, but no info on the number of elements

function foo(x)
    tup   = Tuple(x)       # type `Tuple{Vararg(Int64)}` (`Vararg` is "variable number of arguments")
    slice = tup[1:2]       # compiler smart enough to identify number of elements

    sum(slice)
end

@code_warntype foo(x)      # type STABLE (the sum)