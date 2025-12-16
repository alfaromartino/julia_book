x = rand(10); y = rand(10)

function foo!(x,y)
    @. x = -x
    @. y = -y
end