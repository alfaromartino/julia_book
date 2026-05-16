Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo!(x)
    @inbounds @simd for i in eachindex(x)
        x[i] = x[i] / 0.1 + x[i]^2 / 0.2 + x[i]^3 / 0.3 + x[i]^4 / 0.4
    end
end
@ctime foo!($x) #hide