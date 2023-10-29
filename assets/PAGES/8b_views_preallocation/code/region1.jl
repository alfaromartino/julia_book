x = [1, 2, 3]

function foo(x)
    a = x[1:2]          # it allocates ONE vector -> the slice 'x[1:2]'
    sum(a)
end

@btime foo(ref($x))