x = [1,2,3]

function foo(x)
    a = similar(x); b = similar(x); c = similar(x)    

    # <some calculations using a,b,c>
end

@btime foo(ref($x))