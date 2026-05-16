x = [1,2]; β = 1

function foo(x, β)
    (β < 0) && (β = -β)                # transform `beta` to use its absolute value

    our_filter(x) = x[x .> β]

    return our_filter(x)
end

@code_warntype foo(x, β)                # type unstable