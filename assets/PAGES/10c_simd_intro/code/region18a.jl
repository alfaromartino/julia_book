Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

condition(a)     = (a > 0.1) && (a < 0.7)
branch1(a)       =  a * 1.1
branch2(a)       =  a * 1.2

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = if condition(x[i])
            branch1(x[i])
        else
            branch2(x[i])
        end
    end

    return output
end
@ctime foo($x) #hide