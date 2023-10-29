x = [-1,2,3]

temp1  = abs.(x)
temp2  = temp1 ./ sum(temp1)
output = round.(temp2)