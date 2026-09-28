x   = [1, 2, "hello"]     # 'Vector{Any}' has no info on each individual type or number of elements

function foo(x)
    tup   = Tuple(x)      # Tuple with type elements `Any` and undefined number of arguments 
    

    sum(tup)
end

@code_warntype foo(x)     # type UNSTABLE