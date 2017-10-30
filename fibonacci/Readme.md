## Fibonacci
*Calculate the *n*th digit of the Fibonacci sequence.*

I think its safe to say that no software developer in their day to day work has ever actually had to write this algorithm.  Like most coding interview questions, it's not representative of the real work of software development.  Short of telling the interviewer how dumb it is, look at how you can use this question to show what you can do.

The gut instinct on this one is to use recursion.  In fact the interviewer might be wanting you to do that very thing to show that you understand the concept.  It even seems to make sense to do since f(n) == f(n-1) + f(n-2), but in the words of our favorite Admiral...

### It's a trap!
The recursive approach to this question is inefficient and unnecessary.  This is the common implementation using recursion.  It works fine, and returns the 23rd digit in roughly 1/100th of a second.

> [./recursive_fib.rb](./recursive_fib.rb)

```Ruby
def recursive_fib(n)
  return n if (0..1).include? n
  (recursive_fib(n-1) + recursive_fib(n-2))
end
```

So, what's the problem?  Well, since the function often calls itself twice with each pass the number of calls grows exponentially with the digit being calculated.  It's not quite 2^n, closer to 2^(.75n), but that's still really bad!  Calculating the 35th digit takes almost 4 seconds and 29,860,703 function calls; the 40th digit takes over 40 seconds and 331,160,281 function calls; and I got tired of waiting for it to finish the 45th (8.5 minutes, 3.67 billion calls).

Fibonacci is a simple calculation to iterate over, so don't over think it.  Here's the most basic implementation I've come up with; on my computer it calculates the millionth Fibonacci digit in about 18 seconds.

> [./simple_fib.rb](./simple_fib.rb)

```Ruby
def simple_fib(n)
  x,y = [0,1]
  for i in 0..(n-1)
    x,y = [y,x+y]
  end
  return x
end
```

Sure, it's three more lines of code, but its straight forward, simple, and damn is it fast.

### Caching

Wait, can't you speed up the recursive approach with cacheing!? Sure you can, like this:

> [./recursive_fib_with_cache.rb](./recursive_fib_with_cache.rb)

```Ruby
def recursive_fib_with_cache(n)
  @cache ||= {}
  return n if (0..1).include?(n)
  return @cache[n] if @cache[n]
  @cache[n] = (recursive_fib_with_cache(n-1) + recursive_fib_with_cache(n-2))
end
```

Before you recursively call the function, check the cache to see if you already have the value.  If you don't make your calls to calculate it and store it in the cache.  It's easy, and it works.  Now calculating the 45th digit of Fibonacci is practically instant (4.6e-05 seconds) and only takes 89 function calls. Great, right? Let's try for the millionth digit again.  I wonder if it can beat the 18 seconds from the simple approach...

> SystemStackError: stack level too deep

Damn! Turns out this implementation will hit a stack level too deep error when calculating digit 9345 or greater.  This is simply a limitation of Ruby, and while there are some possible work arounds, infinite stack depth isn't really a solution.

At the largest digit I can calculate with this function, 9344, I get my result in 1/100 of a seconds, which is still slower that the 8/1000 of a second it takes with simple_fib. Simple Fib for the win! ...but wait, there's more!

### OO

The previous examples as so... functional, but Ruby is an Object Oriented Language. We should a model for this, but we shouldn't just wrap it up in a class without making it better.  We can move the starting values into the initialize method, set the defaults, but add support for nonstandard starting numbers.

> [./fib_class.rb](./fib_class.rb)

```Ruby
class Fib
  def initialize(x=0, y=1)
    @x, @y = [x,y]
  end

  def calc(n)
    x,y = [@x,@y]
    for i in 1..(n)
      x,y = [y,x+y]
    end
    x
  end
end
```

There's one more thing we should do to make this better.  In fact, its the thing we should have done first...

### Unit Test

We know that TDD is the right thing to do, so do it, even in a stupid coding interview.  Here I've broken up the tests into their own file, but most coding interviews only give you a glorified text editor.  That's fine, just put the tests at the bottom after the class and everything should run just fine.  There's probably not a test framework available, so don't rely on one.  Just check that you are getting the results back you expect and print out the result.

> [./fib_test.rb](./fib_test.rb)

```Ruby
require './fib.rb'
f1 = Fib.new
p f1.calc(0) == 0
p f1.calc(10) == 55
p f1.calc(100) == 354224848179261915075

f2 = Fib.new(3,4)
p f2.calc(5) == 29
p f2.calc(20) == 39603
```
