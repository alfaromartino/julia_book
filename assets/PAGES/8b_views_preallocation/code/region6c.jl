x = [1,2,3]

function foo(x)
    a,b,c = [similar(x) for _ in 1:3]

    # here we'd have calculations using a,b,c
end

@btime foo(ref($x))