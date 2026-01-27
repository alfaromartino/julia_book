function foo()
    rang = 1:3

    sum(rang[1:2]) + rang[2] * rang[3]
end

@ctime foo() #hide