x       = collect(1:100)


@views function foo(x)
    sum(x[1:2:end])
end

@btime foo(ref($x));