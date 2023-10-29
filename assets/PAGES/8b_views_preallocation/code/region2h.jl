using Skipper
x = collect(1:100)

@views function foo(x)
    sum(skip(isodd, x))
end

@btime foo(ref($x));