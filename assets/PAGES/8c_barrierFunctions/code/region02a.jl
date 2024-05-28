x            = ["a", 1]                     # variable with type 'Any'



function foo(x)
    y = x[2]
    
    [y * i for i in 1:100]
end