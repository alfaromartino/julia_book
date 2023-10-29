function totals(audience_per_video, money_per_view)
    audience_total  = sum(audience_per_video)

    money_per_video = audience_per_video .* money_per_view
    money_total     = sum(money_per_video)
    
    return audience_total, money_per_video, money_total
end

audience_total, money_per_video, money_total = totals(audience_per_video, money_per_view)