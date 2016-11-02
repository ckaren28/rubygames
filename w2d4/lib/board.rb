class Board
  attr_reader :grid, :mark

  def initialize(grid = Array.new(3){ Array.new(3) })
    @grid = grid
    @mark = [:X, :O]
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def place_mark(pos, mark)
    self[*pos] = mark
  end

  def empty?(pos)
    if self[*pos] == nil
      return true
    else
      return false
    end
  end

  def winner
    (grid + cols + diagonals).each do |triple|
      return :X if triple == [:X, :X, :X]
      return :O if triple == [:O, :O, :O]
    end

    nil
  end

  def cols
    cols = [[], [], []]
    grid.each do |row|
      row.each_with_index do |mark, col_idx|
        cols[col_idx] << mark
      end
    end

    cols
  end

  def diagonals
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[0, 2], [1, 1], [2, 0]]

    [down_diag, up_diag].map do |diag|
      diag.map { |row, col| grid[row][col] }
    end
  end

  def over?
    grid.flatten.none? { |pos| pos.nil? } || winner
  end

end
