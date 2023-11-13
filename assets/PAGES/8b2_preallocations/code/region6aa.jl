using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function update_temp!(x, temp, i)
    for j in eachindex(x)        
       temp[j] = x[j] > x[i]
    end    
end

function foo!(x; output = similar(x), temp = similar(x))
    for i in eachindex(x)
        update_temp!(x, temp, i)
        output[i] = sum(temp)
    end

    return output
end

@btime foo!(ref($x))