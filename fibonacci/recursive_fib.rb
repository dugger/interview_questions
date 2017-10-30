def recursive_fib(n)
  return n if (0..1).include? n
  (recursive_fib(n-1) + recursive_fib(n-2))
end
