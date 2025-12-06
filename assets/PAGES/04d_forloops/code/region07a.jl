x = 2

for x in ["hello"]          # this 'x' is local, not related to 'x = 2'
    println(x)
end