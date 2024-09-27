using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    output = 0.
    for i in eachindex(x)
        output += 3 * x[i]
    end

    return output
end

calling_foo_in_a_loop(x) = [foo(x) for _ in 1:100]

@btime calling_foo_in_a_loop(ref($x))