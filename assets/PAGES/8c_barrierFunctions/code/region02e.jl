x = ["a", 1]                     # variable with type 'Any'

operation(y) = [y * i for i in 1:100]

function foo(z)
    y = 2 * z
    
    operation(y)
end