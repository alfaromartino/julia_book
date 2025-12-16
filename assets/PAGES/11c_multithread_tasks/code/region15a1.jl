Random.seed!(1234) #hide
x = rand(1_000_000)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output += log(x[i])
    end

    output
end
foo(x) #hide