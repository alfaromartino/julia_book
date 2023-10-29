new_audience  = copy(audience_per_video)

temp  = @view new_audience[new_audience .< viral_threshold] # or temp = view(new_audience, new_audience .< viral_threshold, :)
temp .= temp .* 1.2

# we reuse the functions we had
new_money_pervideo, new_money_total, new_audience_total = totals(new_audience, money_per_view)

new_nrvideos_viral, new_audience_viral = viral(new_audience, new_money_pervideo, viral_threshold) 
new_audience_share_viral               = share(new_audience_viral, new_audience_total)
new_money_share_viral                  = share(new_money_viral, new_money_total)