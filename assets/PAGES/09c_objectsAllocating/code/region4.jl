function foo()
    tup = (1,2,3)

    sum(tup[1:2]) + tup[3]
end

@ctime foo() #hide