Random.seed!(1234) #hide
x = rand(10_000_000)

function non_threaded(x)    
    a           = maximum(x)
    b           = sum(x)
    
    all_outputs = (a,b)
end
non_threaded(x) #hide