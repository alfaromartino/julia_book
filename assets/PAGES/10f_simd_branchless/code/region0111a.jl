Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(5_000_000)
output = similar(x)

function foo!(output,x)
    for i in eachindex(x)
        output[i] = ifelse(x[i] > 0.5, x[i]/2, 0)
    end
end
@ctime foo!($output,$x) #hide