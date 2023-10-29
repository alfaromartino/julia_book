x       = collect(1:100)
indices = isodd.(1:length(x))

@views function foo(x, indices)
    sum(x[indices])
end

@btime foo(ref($x), ref($indices));