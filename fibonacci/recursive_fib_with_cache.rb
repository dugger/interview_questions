def recursive_fib_with_cache(n)
  @cache ||= {}
  return n if (0..1).include?(n)
  return @cache[n] if @cache[n]
  @cache[n] = (recursive_fib_with_cache(n-1) + recursive_fib_with_cache(n-2))
end
