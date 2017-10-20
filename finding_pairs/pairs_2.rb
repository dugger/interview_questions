def test(ar, target)
  result = []
  while ar.size > 0
    x = ar.pop
    y = ar.find{|i| i+x==target}
    if y
      result << [x,y]
      ar.delete(y)
    end
  end
  return result
end

test([2,8,1,9], 10)
test([2,8,1,9,8], 10)


# use an array.find
