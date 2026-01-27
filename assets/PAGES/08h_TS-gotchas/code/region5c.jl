x = [1,2,3]

function foo(x, ::Val{N}) where N
    tuple_x = NTuple{N, eltype(x)}(x)   

    2 .+ tuple_x    
end

@code_warntype foo(x, Val(length(x)))   # type stable