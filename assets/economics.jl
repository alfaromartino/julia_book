
using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided, Distributions, Random, Pipe, BrowseTables, NLsolve
#using DataFrames, BenchmarkTools, BrowseTables, Distributions, Random, Pipe
using LazyArrays, Random
Random.seed!(234)
browse(x) = open_html_table(x)

nr_firms = 1_000
const σ  = 3.5
revenue  = rand(Pareto(log(4,5)), nr_firms)
mshare   = @pipe sum(revenue) |> revenue./ _ |> sort!

                 
elast(mshare, σ)     = σ + mshare * (1 - σ)
markup(mshare,σ)     = elast(mshare,σ) / (1 + elast(mshare,σ))

attraction(mshare,σ) = markup(mshare,σ)^(1-σ)

share_fun(mshare,σ)  = attraction(mshare,σ) / Phat^(1-σ)
Phat_fun(mshare,σ)   = sum(attraction(mshare,σ))

attractions(mshare,σ)= (attraction(mshare[i],σ) for i in eachindex(mshare))
sum_shares(mshare,σ)   = sum(attractions(mshare,σ))^(1/(1-σ))
    
@time sum_shares(mshare,σ)



function Phats_solver_mkPower(ind; Âh, t̂ic)
    (; swl, eₕ, Sl, swi, eᵢ, Si, Smc) = ind    
    
    function solver!(res,Phats)
        (P̂)         =   Phats 
        (ŝω,_)      =   mshare_solver(P̂l, P̂h, eₕ, swl, Sl, 1.0)                
        Ŝ           =   (P̂l/P̂h)^(1-σ)
        
        res[1]      =   @turbo sum(ŝwl.*swl) - 1.0        
        res[3]      =   @turbo Ŝ * S - 1.0
    return res
    end

    function execute()
        sol0        =   [0.5 ; 0.3 ; 0.5]
        solution    =   nlsolve(solver!, sol0, xtol=0.0, ftol = 1e-8, iterations =Int(1e5))
        converged(solution) ||  error("Failed to converge") 

        (P̂l,P̂h,P̂i)  =   solution.zero
    end
    return execute()
end
