vec1 = ["a", "b", "c"] ; vec2 = [1, 2, 3]
data = [vec1, vec2] 

function foo(data) 
    for i in eachindex(data[2])
        data[2][i] = 2 * i
    end
end

@code_warntype foo(data)            # type UNSTABLE
#@btime foo(ref($data)) #hide