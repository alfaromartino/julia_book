function foo(type)
    size = 100
    x    = ones(type, size)
    
    sum(x)
end

#@btime foo(Int64) #hide