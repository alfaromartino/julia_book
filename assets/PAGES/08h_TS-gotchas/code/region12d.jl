x = [1,2]; β = 1

function foo(x, β)
    δ = (β < 0) ? -β : β        # transform 'β' to use its absolute value    

    bar(x) = x * δ

    return bar(x)
end

@code_warntype foo(x, β)        # type stable