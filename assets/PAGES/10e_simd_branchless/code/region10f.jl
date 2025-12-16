Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(1_000_000)
output = similar(x)

function foo!(output, x)
    for i in eachindex(x)
        output[i] = 2 / x[i]
    end
end
@ctime foo!($output,$x) #hide