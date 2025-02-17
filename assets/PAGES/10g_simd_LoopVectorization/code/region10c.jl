Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = copy(x)

    @turbo for i in 2:length(x)
        output[i] = output[i-1] + x[i]
    end

    return output
end
print_compact(sum(foo(x))) #hide