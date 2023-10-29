x = [1, 2, 3]

function foo(x)    
    sum(x[1:2])         # it allocates ONE vector -> the slice 'x[1:2]'
end

@btime foo(ref($x))