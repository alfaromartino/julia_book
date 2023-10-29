x = [1,2]; β = 1

function foo(some_vector, β)
    β = abs(β)                           # but δ = abs(beta) preferable
    
    filter(x -> x > β, some_vector)      # keep elements greater than beta
end

@code_warntype foo(x, β)                 # type unstable