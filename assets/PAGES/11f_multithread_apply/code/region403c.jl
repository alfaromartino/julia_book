Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    output = similar(x)

    @sync for i in eachindex(x)
        @spawn output[i] = sum(@~ log.(x[1:i]))
    end

    return output
end
foo(x); #hide