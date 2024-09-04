function foo()
    rang = 1:3

    rang[1] + rang[2] * rang[3]
end

@btime foo() #hide