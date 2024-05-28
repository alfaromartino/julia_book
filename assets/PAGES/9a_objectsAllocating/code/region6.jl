function foo()
    nt = (a=1, b=2, c=3)

    nt.a + nt.b * nt.c
end

@btime foo() #hide