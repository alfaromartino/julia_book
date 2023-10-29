using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

update_temp!(x, temp) = (@. temp = 2 * x)
    
function compute_output(x)
    output = similar(x)
    temp   = similar(x)

    for i in eachindex(x)
        update_temp!(x, temp)
        output[i] = sum(temp) + i
    end

    return output
end

@btime compute_output(ref($x))