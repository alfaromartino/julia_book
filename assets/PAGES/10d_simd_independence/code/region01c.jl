Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(10_000_000)

function foo(x)
    output = 0.0

    for a in x
        output += a
    end

    return output
end
@ctime foo($x) #hide