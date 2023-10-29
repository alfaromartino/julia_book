x = [1,2]; β = 1

function foo(x, β)
    δ = (β < 0) ? -β : β        # define 'δ' as the absolute value of 'β'
    
    filter(x -> x > δ, x)       # keep elements greater than 'δ'
end

@code_warntype foo(x, β)        # type stable