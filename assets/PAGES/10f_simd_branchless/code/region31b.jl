Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(5_000_000)
output = similar(x)

function foo!(output,x)
    @inbounds @simd for i in eachindex(x)
        if x[i] > 0.5
            output[i] = log(x[i])
        end
    end
end
@ctime foo!($output,$x) #hide