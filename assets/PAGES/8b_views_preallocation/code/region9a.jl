using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x             = rand(100)
length_output = 1_000

function compute_temp(x)
    temp = similar(x)

    for i in eachindex(x)
        temp[i] = 2 * x[i]
    end

    return temp
end

function compute_output(x, length_output)
    output = Vector{Float64}(undef, length_output)
    
    for i in 1:length_output
        temp      = compute_temp(x)
        output[i] = sum(temp) + i
    end

    return output
end

@btime compute_output(ref($x), ref($length_output))