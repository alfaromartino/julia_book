x         = 2

function foo(x)
    for _ in 1:100_000
       log(x)
    end
end

@btime foo($x)    # hide