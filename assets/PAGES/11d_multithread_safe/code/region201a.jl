function foo(nr_iterations)
    for i in 1:nr_iterations
      job(i; time_working = i)      
    end
end
foo(1); #hide