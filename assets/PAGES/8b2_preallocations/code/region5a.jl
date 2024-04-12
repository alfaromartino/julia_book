using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo!(x; output = similar(x), temp = similar(x))
    for i in eachindex(x)        
        for j in eachindex(x)
            temp[j] = x[j] > x[i]
        end
        output[i] = sum(temp)
    end

    return output
end

@btime foo!(ref($x)) #hide