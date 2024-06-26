const k1  = 2

foo() = [abs(k1) for _ in 1:100]
        
@btime foo() # hide