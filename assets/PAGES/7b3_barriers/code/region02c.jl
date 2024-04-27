x            = ["a", 1]                     # variable with type 'Any'



function foo(x)
    y = 2 * x[2]
    
    return [y * i for i in 1:100]
end