require './fib.rb'
f1 = Fib.new
p f1.calc(0) == 0
p f1.calc(10) == 55
p f1.calc(100) == 354224848179261915075

f2 = Fib.new(3,4)
p f2.calc(5) == 29
p f2.calc(20) == 39603
