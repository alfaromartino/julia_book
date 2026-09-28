x                        = [0, 5, 10]
list_functions           = [minimum, maximum]

descriptive(vector,list) = [foo(vector) for foo in list]
print_asis(descriptive(x, list_functions))  #hide