x = [1,2]; β = 1

function foo(x, β)
    β = abs(β)                  # 'δ = abs(β)' is preferable (you should avoid redefining variables) 
    
    filter(x -> x > β, x)       # keep elements greater than β
end

@code_warntype foo(x, β)        # type stable