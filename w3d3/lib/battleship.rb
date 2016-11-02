require_relative "board"
require_relative "player"

class BattleshipGame
  attr_reader :board, :player1, :player2, :current_player, :hit

  def initialize(player1 = HumanPlayer.new("Karen"), player2 = HumanPlayer.new("Mike"), board = Board.random)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player = player1
    @hit = false
  end

  def switch_players!
    @current_player = current_player == player1 ? player2 : player1
  end

  def attack(pos)
    if board[pos] == :s
      @hit = true
    else
      @hit  = false
    end

    @board[pos] = :x
  end

  def place_ship(size, start_pos, direction)

    case direction
    when  "horizontal"
      (start_pos[1]...start_pos[1] + size.to_i).each do |col|
        @board[start_pos[0], col] = :s
      end
    when "veritical"
      (start_pos[0]...start_pos[0] + size.to_i).each do |row|
        @board[row, start_pos[1]] = :s
      end
    end

  end

  def count
    @board.count
  end

  def hit?
    @hit
  end

  def game_over?
    @board.won?
  end

  def play_turn
    pos = nil
    until valid_play?(pos)
      display_status
      pos = @current_player.get_play
    end
    attack(pos)
    switch_players!
  end

  def valid_play?(pos)
    pos.is_a?(Array) && board.in_range?(pos)
  end

  def play
    i = 5
    while i > 0
      place_ship(i, player1.get_play, player1.get_direction)
      place_ship(i, player2.get_play, player2.get_direction)
      i -= 1
    end

    play_turn until game_over?
    declare_winner
  end

  def declare_winner
    puts "You WIN"
  end

  def display_status
    system('clear')
    board.display
    puts "HIT!" if hit?
    puts "There are #{count} ships remaining."
  end


end



if __FILE__ == $PROGRAM_NAME
  BattleshipGame.new.play
end
