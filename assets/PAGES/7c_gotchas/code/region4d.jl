vec1 = ["a", "b", "c"] ; vec2 = [1, 2, 3]
data = [vec1, vec2] 

operation(i) = (2 * i)

function foo(data) 
    for i in eachindex(data[2])
        data[2][i] = operation(i)
    end
end

@code_warntype foo(data)            # type unstable