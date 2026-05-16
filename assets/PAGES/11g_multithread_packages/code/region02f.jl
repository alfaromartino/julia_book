Random.seed!(1234) #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    tmap(eachindex(x)) do i
        output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide