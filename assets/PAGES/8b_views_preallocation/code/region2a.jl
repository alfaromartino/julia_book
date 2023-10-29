x = [1, 2, 3]

function foo(x)
    a = x[1:2]
    b = x[2:3]

    sum(a) * sum(b)
end

replicate(x) = [foo(x) for _ in 1:100]

@btime replicate(ref($x))