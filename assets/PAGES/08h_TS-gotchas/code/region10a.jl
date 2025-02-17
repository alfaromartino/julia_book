x = [1,2]; β = 1

function foo(x, β)
    (β < 0) && (β = -β)         # transform 'β' to use its absolute value
    
    filter(x -> x > β, x)       # keep elements greater than 'β'
end

@code_warntype foo(x, β)        # type UNSTABLE