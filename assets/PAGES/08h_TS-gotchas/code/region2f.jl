x = [1,2]; β = 1

function foo(some_vector, β)
    (β < 0) && (β = - β)                # transform `beta` to use its absolute value
    
    filter(x -> x > β, some_vector)     # keep elements greater than beta
end

@code_warntype foo(x, β)                # type unstable