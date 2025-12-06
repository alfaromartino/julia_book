#functions to compute expenditure
expenditure(price, quantity, tax_rate) = price * quantity * (1 + tax_rate)




#information 
price    = 1000
quantity = 2
tax_rate = 5 / 100

#computation
expenditure_iPhones = expenditure(price, quantity, tax_rate)