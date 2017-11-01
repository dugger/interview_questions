## Fibonacci
*Calculate the *n*<sup>th</sup> digit of the Fibonacci sequence.*

I think it's safe to say that no software developer in their day to day work has ever actually had to write this algorithm.  Like most coding interview questions, it's not representative of the real work of software development.  How do you deal with this?  Well, short of telling the interviewer how dumb it is, let's see how you can use this question to show that you can write actual code and not just output memorized functions.

### Recursion

The gut instinct on this one is to use recursion.  In fact the interviewer might be wanting you to do that very thing to show that you understand the concept.  It even seems to make sense to do since Fibonacci is just:

```f(n) == f(n-1) + f(n-2)```

In the words of our favorite Admiral...

*__It's a trap!__*

The recursive approach to this question is inefficient, unnecessary, and doesn't really work.  Here is the common implementation using recursion.  It seems to work, and returns the 23rd digit in roughly 1/100th of a second.

> [./recursive_fib.rb](./recursive_fib.rb)
```Ruby
def recursive_fib(n)
  return n if (0..1).include? n
  (recursive_fib(n-1) + recursive_fib(n-2))
end
```

So, what's the problem?  Well, since the function often calls itself twice with each pass the number of calls grows exponentially with the digit being calculated.  It's not quite 2^n, closer to 2^(.75n), but that's still really bad!  Calculating the 35th digit takes almost 4 seconds and 29,860,703 function calls; the 40th digit takes over 40 seconds and 331,160,281 function calls; and I got tired of waiting for it to finish the 45th at 8.5 minutes and 3.67 billion calls.

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

"Wait", the interviewer might say, "can't you speed up the recursive approach with caching!?"

Sure you can, like this:

> [./recursive_fib_with_cache.rb](./recursive_fib_with_cache.rb)
```Ruby
def recursive_fib_with_cache(n)
  @cache ||= {}
  return n if (0..1).include?(n)
  return @cache[n] if @cache[n]
  @cache[n] = (recursive_fib_with_cache(n-1) + recursive_fib_with_cache(n-2))
end
```

Before recursively calling the function (twice), I check the cache to see if I already have the value.  If not, make the calls to calculate it and store it in the cache.  It's easy, and it works.  Now calculating the 45th digit of Fibonacci is practically instant (4.6e-05 seconds) and only takes 89 function calls. Great, right? Let's try for the millionth digit again.  I wonder if it can beat the 18 seconds from the simple approach...

> SystemStackError: stack level too deep

Damn! Turns out this implementation will hit a stack level too deep error when calculating digit 9345 or greater.  This is simply a limitation of Ruby, and while there are some possible work arounds, infinite stack depth isn't really a solution, and even if it was, this approach isn't faster. At the largest digit I can calculate with this function, 9344, I get my result in 1/100 of a seconds, which is still slower that the 8/1000 of a second it takes with simple_fib.

Simple Fib for the win! ...but wait, there's more!

### OO

The previous examples as so... functional, but Ruby is an Object Oriented Language. We should make a model for this, but don't just wrap it up in a class without making it better.  We can move the starting values into the initialize method, set the defaults, and add support for nonstandard starting numbers.

> [./fib.rb](./fib.rb)
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

That's a bit more like the code I write at my job, and it has more options to boot.

There's one more thing I would do to make this better.  In fact, its the thing I should have done first...

### Unit Tests

Test Driven Development is the right thing to do, so do it, even in a stupid coding interview.  Here I've broken up the tests into their own file, but most coding interviews only give you a glorified text editor.  That's fine, just put the tests at the bottom after the class and everything should run just fine.  There's probably not a test framework available, so don't rely on one.  Just check that you are getting the results back you expect and print out the result.

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

Sure, these tests are very basic, just asserting we get the value we expect, but this problem isn't complicated and the expected results are known values, so I'll leave it at that.

I could go on and test what happens when we pass a negative number to the calc method, or when we pass a string or other object to when we initialize.  This code doesn't do any input validation, so it wont handle those cases well.  I think I'll save that for another time.
