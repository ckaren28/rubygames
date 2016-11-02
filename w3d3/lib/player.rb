require_relative "board"

class ComputerPlayer
  attr_reader= :board

  def initialize(name)
    @name = name
  end

  def get_direction
    direction = ["horizontal", "veritical"].sample
  end


  def display(board)
    @board = board
  end

  def get_play
    pos = board.random_pos until board.empty?(pos)
    pos
  end

end


class HumanPlayer
  attr_reader= :name

  def initialize(name)
    @name = name
  end

  def get_direction
    puts "Place ship VERTICAL or HORIZONTAL?"
    direction = gets.chomp
  end


  def get_play
      pos = Integer(gets.chomp.split(", "))

  end

  def prompt
    puts "Please enter a target square (i.e., '3,4')"
    print "> "
  end



end
