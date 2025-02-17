x       = [1,2,3]


function foo(x)                         # 'Vector{Int64}' has no info on the number of elements
    tuple_x = Tuple(x)          

    2 .+ tuple_x
end

@code_warntype foo(x)                   # type UNSTABLE
# @btime foo(ref($x))           #hide