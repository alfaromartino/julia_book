Random.seed!(123)       #setting seed for reproducibility #hide
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = 0.0
    
    for i in eachindex(x)
        output += calculation(x[i])
    end

    return output
end
@ctime foo($x) #hide