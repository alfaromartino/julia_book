
using DataFrames,BenchmarkTools, LoopVectorization, FastBroadcast, Formatting, Distributions, Random, Pipe, StaticArrays, Strided
using BrowseTables, #Polyester
browse(x) = open_html_table(x)


###########################################
#               CREATE FAKE DATA
###########################################

Random.seed!(123) # Setting the seed

nr_firms_per_industry                         = 400
nr_industries                                 = 4_000 # same as 10 years with 400 industries
distribution_revenues                         = Pareto(log(4,5)) #80-20 rule
revenues(distribution, nr_firms_per_industry) = rand(distribution, nr_firms_per_industry) 

function info_industries(distribution_revenues, nr_firms_per_industry) 
    ind = Int64[]
    rev = Float64[]
        for i in 1:nr_industries
            append!(ind, repeat([i*10], nr_firms_per_industry))
            append!(rev, revenues(distribution_revenues, nr_firms_per_industry))
        end
    return ind,rev
end


dff = @pipe info_industries(distribution_revenues, nr_firms_per_industry) |> 
             DataFrame([:industry, :revenue] .=> _)


## ADD MISSING VALUES
#=nr_missing                  = Int(floor(0.05 * nr_firms_per_industry * nr_industries))
index_missing               = rand(1:(nr_firms_per_industry * nr_industries), nr_missing)

allowmissing!(dff, :revenue)
    dff[index_missing, :revenue] .= missing=#

## ADD EXPORTERS
nr_exporters_per_industry  = 100
proportion_exporting       = 0.3
dff.isexporter            .= false  
sort!(dff,[:industry,:revenue], rev=true)


function add_exporters!(dfg, nr)    
    for i in eachindex(dfg)
        dfg[i][1:nr, :isexporter] .= true
    end
end
add_exporters!(groupby(dff,:industry), nr_exporters_per_industry)

dff.exports .= 0 
    dft = view(dff, dff.isexporter.==true, :)
    dft[!,:exports] =  dft[!,:revenue] .* proportion_exporting .* rand() ./ 0.5 



###########################################
#               FUNCTION TO BE CONSIDERED `FOO`
###########################################
foo(x,a) = x / a * 100 + x^2 / a^3 * 100 + log(x) + a^2 * exp(x)
foo(x,a) = x / a * 100 

#AUXILIAR
function pre_allocate(x)
    eltype(x) isa Union ?
    (c = Vector{Union{Float64,Missing}}(undef,length(x))) :
    (c = Vector{Float64}(undef,length(x)))
    return c
end


        
##############################################################################
#                                   STANDARD LOOPS
##############################################################################
dfa = copy(dff)

    function share(c,x,df)
        a = sum(x)
        #=for j in 1:nrow(df)
            c[j] = a
        end=#
    end

    function iter(func, dfa, dfg, groups, pre_alloc, col) 
        dfa[!, pre_alloc] = similar(dfa[!, col])
        
        for i in eachindex(dfg)
            for j in 1:size(dfg)[1]
            dfa[dfa[!,groups].==group(j), pre_alloc] .= func(dfg[i][!, pre_alloc], dfg[i][!, col], dfg[i])
            end    
        end
    end


function mutate2(func, dfa, groups, pre_alloc, col)
        dft = dropmissing(dfa, :exports, view=true)
        dft1 = view(dft, dft.isexporter.==true, :)
        dfg = groupby(dft1, [:industry])
    
        nt = Dict.(keys(dfg))
        group(i) = nt[i][:industry]
        #transform!(dfg, :revenue => sum ∘ skipmissing => :revexp)
    
    iter(func, dfa, dfg, groups, pre_alloc, col) 
end

mutate2(sum, dft, :industry, :cal, :exports) 



dfa = copy(dff)

function mutate!(dfa, cond, groups, func, pre_alloc, col)
    dft = view(dfa, cond, :)
    dfg = groupby(dft, groups)
    
    aa = combine(dfg, col => func => pre_alloc)
    leftjoin!(dfa, aa, on=groups)
end
mutate!(dft, dft.isexporter.==true, :industry, sum, :cal, :exports)


dfa = copy(dff)
function mutate!(dfa, cond, groups, func, pre_alloc, col)
    dft = view(dfa, cond, :)
    dfg = groupby(dft, groups)
    
    aa = combine(dfg, col => func => pre_alloc)
    leftjoin!(dfa, aa, on=groups)
end
mutate!(dft, dft.isexporter.==true, :industry, sum, :cal, :exports)
## test combine(sdf -> sdf[argmax(sdf.revenue), [:revenue, :exports]], groupby(dff, :industry))

#=

#INITIALIZE DATAFRAME FOR STORING RESULTS
dfr = DataFrame(seconds = Float64[], case = String[])

function store_result!(dff, dfg, case_name, share)
    push!(dff.seconds, @belapsed(transform(dfg, :revenue => share => :share)))
    push!(dff.case, case_name)
end
=#

#=
###RESULT IN MILISECONDS
function rescale_time(result, digits; format=false) 
#    printx(x,N) = sprintf1("%.$(N)f",x)
    a = result * 1e3  # to translate time into miliseconds (ms) use 1e3
    a = round(a, digits=digits)
    (format == true) && (a = format(a))    

    return a
end

output = copy(dfr)

output.ms = rescale_time.(output.seconds, 1)
output.rate = round.(output[:, :ms] ./ output[output.case.=="standard",:ms] .* 100, digits=2)
sorted3  = sort(output, :seconds)

browse(sorted3)=#