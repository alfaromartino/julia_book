a    = 1
funs = [log, exp]

function foo(funs)
    y = [fun(a) for fun in funs]

    for _ in 1:1_000
        sum(y)
    end
end

@btime foo($funs) #hide