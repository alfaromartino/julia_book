Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)
y = @view x[sortperm(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide