#=function example(x)
    for i in eachindex(x)
        if x[i] < 500
            x[i] = x[i] + 1
        else
            x[i] = x[i] / 2
        end
    end
end

#Rewrite this function by using alternatives way to write loops =#



function example(x)
    a = x > 1 ? 1 : x
    a = a / 2
    
    return a
end

@code_warntype example(1.0)



function example2(x)
    a = x > 1 ? 1.0 : convert(Float64,x)
    a = a / 2    
    
    return a
end

@code_warntype example2(1.0)


function example3(x)
    a = x > 1 ? 1 : x

    f(a) = a / 2
    a = f(a)
    
    return a
end

@code_warntype example3(1.0)



#################################################################
x = rand(100_000)
y = rand(100_000)

b = [x[i] * 2  for i in eachindex(x)] #trivial
b = x .* 2 #equivalent


#for example keep the top incomes of companies and multiply it by the exchange rate
b = [x[i] * 2  for i in eachindex(x) if x[i]>0.5] #not trivial
b = x[x.>0.5] .* 2 #equivalent

#useful to construct pairs
b = [(x,y) for x in 1:3, y in 1:3] #pairs

#useful to mix variables
b = [x[i] * 2  for i in eachindex(x) if y[i]>0.5] 
b = x[y.>0.5] .* 2 #equivalent

b = [x[i] * 2  for i in eachindex(x) if i>=100] 
b = x[100:end] .* 2 


#more useful if we use
b = [i * 2 for i in 1:100]


#################################################################
#EXERCISE
#################################################################
using Distributions, Pipe, BenchmarkTools, Statistics
income = rand(Pareto(1.16),1_000_000) #80-20 rule

#revenues share
@benchmark share = income ./ sum(income) * 100

@benchmark share = @pipe sum(income)* 100 |>
                         income ./ _ 
sort!(share)


#we can calculate it differently
function share_rev1(income) 
    aux   =  sum(income)
    share = [income[i] / aux for i in eachindex(income)]

    return share
end

@benchmark share_rev1(income)


function share_rev2(income) 
    aux   =  sum(income)
    share = similar(income)

    for i in eachindex(income)
        share[i] = income[i] / aux 
    end

    return share
end

share_rev2(income)

aux = sum(income)
@benchmark share = [income[i] / aux for i in eachindex(income)]
@benchmark share = share_rev1(income)


@time sum(income[i] for i in eachindex(income))
@time sum(income)



b = Vector{Float64}(undef,3)
b = [f(income) for f in [mean,median,std]]

stat = Dict([:mean,:median,:std] .=> b)
(; stat...)
NamedTuple(stat)


#### DATAFRAMES
using DataFrames, CSV, CategoricalArrays,PooledArrays,Tables

df = DataFrame(x = rand(3_000_000), y = rand(3_000_000), z = repeat(["a","b"], 1_500_000))
df.z2 = String1.(df.z) 
df.z3 = categorical(df.z, compress=true) 
df.z4 = PooledArray(df.z, compress=true) 

@benchmark transform(groupby(df,:z), :x => sum )
@benchmark transform(groupby(df,:z2), :x => sum )
@benchmark transform(groupby(df,:z3), :x => sum )
@benchmark transform(groupby(df,:z4), :x => sum )

mapcols(x-> x^2, df[:,[:x,:y]])

df = DataFrame(x = rand(3_000_000), y = rand(3_000_000), z = repeat(["a","b"], 1_500_000))
@time df[:, [:x,:y]] = mapcols(x -> log.(x), df[:, [:x,:y]]) 

df = DataFrame(x = rand(3_000_000), y = rand(3_000_000), z = repeat(["a","b"], 1_500_000))
@time df[:, [:x,:y]] .= mapcols(x -> log.(x), df[:, [:x,:y]])

df = DataFrame(x = rand(3_000_000), y = rand(3_000_000), z = repeat(["a","b"], 1_500_000))
@time [df[!, col] = log.(df[!, col]) for col in [:x,:y]]

df = DataFrame(x = rand(3_000_000), y = rand(3_000_000), z = repeat(["a","b"], 1_500_000))
@time(@pipe df[:, [:x,:y]] |>
      foreach(x -> log.(x), eachcol(_)))


      aa = Tables.columntable(df)
      bb = Tables.rowtable(df)
      
function foo(df)
    df.x .+ df.y
end

@code_warntype foo(df)
@code_warntype foo(columntable(df))

@benchmark foo(df)
@benchmark foo(columntable(df))
@benchmark df.x .+ df.y



############################################################################################################
# taxing income
#############################################################################################################
using Distributions, Pipe, BenchmarkTools, Statistics, FLoops, FastBroadcast
income = rand(Pareto(1.16),1_000_000) #80-20 rule
sort!(income)

#revenues share
share = income ./ sum(income) * 100
list = collect(0.1:0.1:100) ./ 100

sort!(income)
@time quantile.(Ref(income),list)


function foo(income,list)
    critical = similar(list)
    critical .= [quantile(income,list[i]) for i in eachindex(list)]

    return critical
end
@time foo(income,list)

function foo3(income,list)    
        critical = similar(list)
        [critical[i] = quantile(income,list[i]) for i in eachindex(list)]
    
        return critical
end
@time foo3(income,list)
    

function foo4(income,list)    
    critical = similar(list)
    @floop for i in eachindex(list)
        critical[i] = quantile(income,list[i]) 
    end

    return critical
end


@time foo4(income,list)