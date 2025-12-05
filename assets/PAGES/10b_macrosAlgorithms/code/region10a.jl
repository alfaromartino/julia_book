Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(2_000_000)

function foo!(x)
    for i in eachindex(x)
        x[i] = x[i] * 2
    end
end
@ctime foo!($x) #hide