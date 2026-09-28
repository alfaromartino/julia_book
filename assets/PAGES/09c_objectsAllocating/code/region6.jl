function foo()
    nt = (a=1, b=2, c=3)

    sum((nt.a, nt.b)) + nt.c
end

@ctime foo() #hide