x     = rand(10)

@btime begin
    sum(x)
end
#@code_warntype foo() # hide