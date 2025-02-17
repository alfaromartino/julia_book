x = 1:100

@time sum(x)         # first run                     -> it incorporates compilation time 
@time sum(x)         # time without compilation time -> relevant for each subsequent run