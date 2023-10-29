x = [1, 2, 3]

function foo(x)
    a = view(x, 1:2)    # it doesn't allocate
    sum(a)
end

@btime foo(ref($x))