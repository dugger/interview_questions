def simple_fib(n)
  x,y = [0,1]
  for i in 0..(n-1)
    x,y = [y,x+y]
  end
  return x
end
