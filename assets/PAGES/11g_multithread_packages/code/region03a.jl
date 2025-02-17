Random.seed!(1234) # hide
x = BitVector(rand(Bool, 100_000))

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = !(x[i])
    end

    output
end
@ctime foo($x)  # hide