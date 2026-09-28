β = 3 
δ = 4 
ϵ = 5

# function 'foo' uses β and δ, but not ϵ
function foo(x, δ, β) 
    x * δ + exp(β) / β


end

output = foo(1, δ, β)