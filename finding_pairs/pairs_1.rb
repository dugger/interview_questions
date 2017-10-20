def test(ar, n)
  result = []
  ar.each_with_index do |i, k|
    ar.delete_at(k)
    ar.each_with_index do |x, y|
      if i + x == n
        ar.delete_at(y)
        result << [i, x]
        return
      end
    end
  end
  return result
end

test([2,8,1,9], 10) == [[2,8],[1,9]]
test([2,8,1,9,8], 10) == [[2,8], [2,8], [1,9]]
test([2,8,1,9,2,8], 10) == [[2,8], [2,8], [1,9]]
