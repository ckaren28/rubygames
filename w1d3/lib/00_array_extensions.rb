# Sum
#
# Write an Array method, `sum`, that returns the sum of the elements in the
# array. You may assume that all of the elements are integers.

class Array
  def sum
    sum = 0
    each { |el| sum += el }
    sum
  end
end
# can also use:
# def sum
#    inject(0) {|sum, el| sum + el }
# end


# Square
#
# Write an array method, `square`, that returns a new array containing the
# squares of each element. You should also implement a "bang!" version of this
# method, which mutates the original array.

class Array
  def square!
    map! {|el| el * el }
  end

  def square
    dup.square!
  end
end

# Finding Uniques
#
# Monkey-patch the Array class with your own `uniq` method, called
# `my_uniq`. The method should return the unique elements, in the order
# they first appeared:
#
# ```ruby
# [1, 2, 1, 3, 3].my_uniq # => [1, 2, 3]
# ```
#
# Do not use the built-in `uniq` method!

class Array
  def my_uniq
    uniq_array = []

    self.each do |el|
      uniq_array << el unless uniq_array.include?(el)
    end

    uniq_array
  end
end

# Two Sum
#
# Write a new `Array#two_sum` method that finds all pairs of positions
# where the elements at those positions sum to zero.
#
# NB: ordering matters. I want each of the pairs to be sorted smaller
# index before bigger index. I want the array of pairs to be sorted
# "dictionary-wise":
#
# ```ruby
# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
# ```
#
# * `[0, 2]` before `[1, 2]` (smaller first elements come first)
# * `[0, 1]` before `[0, 2]` (then smaller second elements come first)

class Array
  def two_sum
    pairs = []

    self.count.times do |i1|
      (i1 + 1).upto(self.count - 1) do |i2|
        pairs << [i1, i2] if self[i1] + self[i2] == 0
      end
    end
    pairs
  end
end
# Median
#
# Write a method that finds the median of a given array of integers. If
# the array has an odd number of integers, return the middle item from the
# sorted array. If the array has an even number of integers, return the
# average of the middle two items from the sorted array.

class Array
  def median
    return nil if empty?
    sorted = self.sort
    if length.odd?
      sorted[length / 2]
    else
      (sorted[length / 2] + sorted[length / 2 - 1]).fdiv(2)
    end
  end
end

# My Transpose
#
# To represent a *matrix*, or two-dimensional grid of numbers, we can
# write an array containing arrays which represent rows:
#
# ```ruby
# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]
#
# row1 = rows[0]
# row2 = rows[1]
# row3 = rows[2]
# ```
#
# We could equivalently have stored the matrix as an array of
# columns:
#
# ```ruby
# cols = [
#     [0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]
#   ]
# ```
#
# Write a method, `my_transpose`, which will convert between the
# row-oriented and column-oriented representations. You may assume square
# matrices for simplicity's sake. Usage will look like the following:
#
# ```ruby
# matrix = [
#   [0, 1, 2],
#   [3, 4, 5],
#   [6, 7, 8]
# ]
#
# matrix.my_transpose
#  # => [[0, 3, 6],
#  #    [1, 4, 7],
#  #    [2, 5, 8]]
# ```
#
# Don't use the built-in `transpose` method!

class Array
  def my_transpose
    col_dimension = self.first.count
    row_dimension = self.count
    trans_matrix = self.class.new(col_dimension) {self.class.new(row_dimension) }

    row_dimension.times do |i|
      col_dimension.times do |j|
        trans_matrix[j][i] = self[i][j]
      end
    end
    trans_matrix
  end

end

# Bonus: Refactor your `Array#my_transpose` method to work with any rectangular
# matrix (not necessarily a square one).
