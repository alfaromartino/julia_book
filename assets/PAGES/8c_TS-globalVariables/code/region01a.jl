const k1  = 2

function foo()
    for _ in 1:100_000
       2^k1
    end
end

@btime foo()    # hide