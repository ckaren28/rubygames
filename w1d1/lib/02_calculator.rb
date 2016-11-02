
  def add(x, y)
    x + y
  end

  def subtract(x, y)
    x - y
  end

  def sum(num)
    result = 0
    num.each { |el| result += el }
    result
  end

  def multiply(arr)
    result = 1
    arr.each { |el| result = result * el}
    result
  end

  def power(num, power_of)
    num ** power_of
  end

def factorial(num)
  return 1 if num == 0
    arr = (1...num).to_a
    arr.each {|el| num *= el }
    num
 end
