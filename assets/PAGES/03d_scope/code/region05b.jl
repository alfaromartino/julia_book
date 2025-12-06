value_before_taxes(price, quantity)       = price * quantity
valueAdded_tax(price, quantity, tax_rate) = price * quantity * tax_rate     #it'll define the variable 'tax_paid'

expenditure(price, quantity, tax_paid) = value_before_taxes(price, quantity) + tax_paid