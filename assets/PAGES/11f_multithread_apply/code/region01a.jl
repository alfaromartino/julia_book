Random.seed!(1234) # hide
x = rand(10_000_000)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output += log(x[i])
    end

    output
end
@ctime foo($x)  # hide