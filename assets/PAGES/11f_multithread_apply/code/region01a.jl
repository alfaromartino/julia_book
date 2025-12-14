Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(10_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += log(x[i])
    end

    output
end
@ctime foo($x)  #hide