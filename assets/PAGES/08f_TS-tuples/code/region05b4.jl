x   = [1 ,2 ,3]            # 'Vector{Int64}' identifies `Int64`, but no info on the number of elements

function foo(x,limit)
    tup   = Tuple(x)       # type `Tuple{Vararg(Int64)}` (`Vararg` is "variable number of arguments") 
    slice = tup[1:limit]   # compiler won't identify the number of elements through `limit` 

    sum(tup)
end

@code_warntype foo(x,2)    # type UNSTABLE