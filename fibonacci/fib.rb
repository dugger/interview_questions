class Fib
  attr_accessor :cache, :x, :y

  def initialize(x:0, y:1, cache: [])
    self.cache = cache
    @x = x
    @y = y
  end

  def calc(n, x:@x, y:@y)
    for i in 0..(n-1)
      cache[i] = x
      x,y = [y,x+y]
    end
    cache[n] = x
  end

  def calc_with_cache(n)
    cache[n] ? cache[n] : calc(n)
  end
end
