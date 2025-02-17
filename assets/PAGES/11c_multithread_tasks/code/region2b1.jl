Random.seed!(1234) #hide
using Base.Threads      # or `using .Threads`
x = rand(1_000)

function foo(x)
    output = similar(x)

    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end

    return sum(output)
end
print_asis(foo(x)) #hide