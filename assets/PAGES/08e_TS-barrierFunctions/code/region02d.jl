x = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(x)
    y = 2 * x[2]
    
    operation(y)
end