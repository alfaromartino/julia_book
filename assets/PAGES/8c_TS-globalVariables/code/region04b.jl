k2::Int64 = 2

function foo()
    for _ in 1:100_000
       abs(k2)
    end
end

@btime foo()    # hide