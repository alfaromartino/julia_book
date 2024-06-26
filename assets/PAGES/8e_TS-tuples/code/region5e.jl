x       = [1, 2, 3]


function foo(x, N)                      # The value of 'N' isn't considered, only its type (which is just Int64)
    tuple_x = NTuple{N, eltype(x)}(x)   

    2 .+ tuple_x
end

@code_warntype foo(x, length(x))        # type UNSTABLE