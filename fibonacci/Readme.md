## Fibonacci
*Calculate the *n*th digit of the Fibonacci sequence.*

The gut instinct on this one is to use recursion.  In fact the interviewer might be wanting you to do that very thing to show that you understand the concept.  It even seems to make sense to do since f(n) == f(n-1) + f(n-2), but in the words of my favorite Admiral...

#### It's a trap!
The recursive approach to this question is inefficient and unnecessary.  Fibonacci is a simple calculation you iterate over.

### Bonus Points
1. Caching
2. Tests
