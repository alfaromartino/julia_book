x       = collect(1:100)


function foo(x)
    sum(x[1:2:end])
end

@btime foo(ref($x));