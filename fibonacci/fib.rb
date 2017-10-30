class Fib
  def initialize(x=0, y=1)
    @x, @y = [x,y]
  end

  def calc(n, x:@x, y:@y)
    for i in 1..(n)
      x,y = [y,x+y]
    end
    x
  end
end
