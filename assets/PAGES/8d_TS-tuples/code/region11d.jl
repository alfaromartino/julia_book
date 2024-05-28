using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10)

function foo2(x::Vararg{T,N}) where {T,N}
    max(x...)
end
#@btime foo2($x...) #hide