Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(5_000_000)
output = similar(x)

function foo!(output,x)
    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(x[i] > 0.5, log(x[i]), 0)
    end
end
@ctime foo!($output,$x) #hide