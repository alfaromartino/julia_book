function foo()
    tup = (1,2,3)

    tup[1] + tup[2] * tup[3]
end

@ctime foo() #hide