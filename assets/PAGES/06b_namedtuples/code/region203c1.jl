parameters_list = (; β = 3, δ = 4, ϵ = 5)



# function 'foo' uses β and δ, but not ϵ
function foo(x, parameters_list)
    (; β, δ) = parameters_list
    
    x * δ + exp(β) / β
end

output = foo(1, parameters_list)