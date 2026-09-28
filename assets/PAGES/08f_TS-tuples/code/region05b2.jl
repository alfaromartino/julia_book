x   = [1, 2, "hello"]     # 'Vector{Any}' has no info on each individual type or number of elements

function foo(x)
    tup   = Tuple(x)      # Tuple with type elements `Any` and undefined number of arguments
    slice = tup[1:2]      # `Tuple{Any,Any}`, compiler smart enough to identify number of elements  

    sum(slice)
end

@code_warntype foo(x)     # type UNSTABLE (still operating with `Any`)