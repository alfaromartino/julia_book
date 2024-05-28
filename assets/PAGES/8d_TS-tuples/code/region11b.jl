function foo(t::Type{T}) where T
    size = 100
    x    = ones(T, size)
    
    sum(x)
end

#@btime foo(Int64) #hide