require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'


class Game
  attr_accessor :current_player, :player_one, :player_two, :board

  def initialize(player_one, player_two)
    @player_one, @player_two = player_one, player_two
    player_one.mark = :X
    player_two.mark = :O
    @current_player = player_one
    @board = Board.new
  end

  def switch_players!
    self.current_player = current_player == player_one ? player_two : player_one
  end

  def play_turn
    board.place_mark(current_player.get_move, current_player.mark)
    switch_players!
    current_player.display(board)
  end

  def game_winner
    return player_one if board.winner == player_one.mark
    return player_two if board.winner == player_two.mark
    nil
  end


  def play
    current_player.display(board)

    until board.over?
      play_turn
    end

    if game_winner
      game_winner.display(board)
      puts "#{game_winner.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  if $PROGRAM_NAME == __FILE__
    system('clear')
    Karen = ComputerPlayer.new('Karen')
    Mike = HumanPlayer.new('Mike, the COOLEST')
    g = Game.new(Karen, Mike)
    g.play
  end

end
