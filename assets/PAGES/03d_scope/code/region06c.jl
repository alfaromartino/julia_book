#functions to compute expenditure
value_before_taxes(price, quantity)       = price * quantity
valueAdded_tax(price, quantity, tax_rate) = price * quantity * tax_rate

expenditure(gross_value, tax_paid) = gross_value + tax_paid

#information 
price    = 1000
quantity = 2
tax_rate = 5 / 100

#computation
gross_value         = value_before_taxes(price, quantity)
tax_paid            = valueAdded_tax(price, quantity, tax_rate)

expenditure_iPhones = expenditure(gross_value, tax_paid)