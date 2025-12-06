x                        = [10, 50, 100]
list_functions           = [maximum, minimum]

descriptive(vector,list) = [foo(vector) for foo in list]
print_asis(descriptive(x, list_functions))