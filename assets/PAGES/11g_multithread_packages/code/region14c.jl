Random.seed!(1234) # hide
x = rand(1_000)

function foo(x)
    output1 = 0.0
    output2 = 0.0

    @floop for a in eachindex(x)

        @reduce() do (output1; a)
            output1 *= log(a)
        end

        @reduce() do (output2; a)
            output2 += log(a)
        end

    end        
    
    return output1, output2
end
@ctime foo($x)  # hide