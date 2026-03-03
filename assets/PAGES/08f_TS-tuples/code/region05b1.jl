x   = [1, 2, "hello"]     # 'Vector{Any}' has no info on each individual type or number of elements

function foo(x, limit)
    tup   = Tuple(x)      # Tuple with type elements `Any` and undefined number of arguments
    slice = tup[1:limit]  # compiler won't identify number of elements through `limit`

    sum(slice)
end

@code_warntype foo(x,2)   # type UNSTABLE