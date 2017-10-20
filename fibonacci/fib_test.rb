require "benchmark"
require "./fib.rb"
puts f = Fib.new
puts f.cache[50] == nil
puts f.calc_with_cache(100) == 354224848179261915075
puts f.cache[50] == 12586269025
puts Benchmark.realtime {f.calc(1000)} > Benchmark.realtime {f.calc_with_cache(1000)}


# TODO Test nonstadard x & y.
