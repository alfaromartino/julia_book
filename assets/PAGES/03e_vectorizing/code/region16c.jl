a             = 2
b             = [1,2,3]

addition(x,y) = 2 * x + y
curried(x)    = (y -> addition(x,y))

#the following are equivalent
f             = curried(a)             # 'foo1' is a function, and 'y' its argument
g(y)          = addition(2,y)