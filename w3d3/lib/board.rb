class Board
  DISPLAY_HASH = {
    nil => " ",
    :s => " ",
    :x => "x"
  }
  attr_reader :grid

  def self.default_grid
    @grid = Array.new(10) { Array.new(10) }
  end

  def initialize(grid = Board.default_grid, random = false )
    @grid = grid
    randomize if random
  end

  def self.random
    self.new(self.default_grid, true)
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, mark)
    x, y = pos
    grid[x][y] = mark
  end

  def count
    count = 0
    @grid.flatten.each do |el|
      if el == :s
        count += 1
      end
    end
    return count
  end

  def empty?(pos = nil)
    if pos
      self[pos].nil?
    else
       self.count == 0
    end
  end

  def full?
    grid.flatten.none?(&:nil?)
  end

  def place_random_ship
    raise "ERROR" if full?
    pos = random_pos

    until empty?(pos)
      pos = random_pos
    end

    self[pos] = :s
  end

  def randomize(count = 10)
    count.times {place_random_ship}
  end

  def random_pos
    [rand(size), rand(size)]
  end

  def size
    grid.length
  end

  def won?
    if self.empty?
      return true
    else
      return false
    end

  end

  def in_range?(pos)
    pos = (0.. grid.length) , (0 .. grid.length)
  end

  def display
    header = (0..9).to_a.join(" ")
    p " #{header}"
    grid.each_with_index { |row, i| display_row(row, i) }
  end

  def display_row(row, i)
    chars = row.map { |el| DISPLAY_HASH[el] }.join(" ")
    p "#{i} #{chars}"
  end

end
