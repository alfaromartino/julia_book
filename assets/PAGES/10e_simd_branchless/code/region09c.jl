Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo!(x)
    @inbounds @simd for i in eachindex(x)
        x[i] = 2 / x[i]
    end
end
@ctime foo!($x) #hide