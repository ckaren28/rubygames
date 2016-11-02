class Hangman
  MAX_GUESSES = 8
  attr_reader :guesser, :referee, :board

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @num_remaining_guesses = MAX_GUESSES
    @guesses = []
  end

  def setup
    secret_word_length = @referee.pick_secret_word.to_i
    @guesser.register_secret_length(secret_word_length)
    @board = Array.new(secret_word_length)
  end

  def take_turn

    guess = @guesser.guess(@board)


    check = @referee.check_guess(guess)
    self.update_board(guess, check)
    @guesser.handle_response(guess, check)
    @num_remaining_guesses -= 1 if check.empty?
    puts "#{@num_remaining_guesses} guesses left."



  end

  def update_board(guess, indices)
    indices.each { |index| @board[index] = guess }
  end

  def won?
    @board.each do |letter|
      return false if letter == "_"
    end
    return true
  end

  def play

    setup

    while @num_remaining_guesses > 0
      self.display(@board)
      take_turn

      if won?
        self.display(@board)
        puts "Guesser Won!"
        return
      end
    end
    puts "The word was #{@referee.require_secret}"
    puts "Guesser LOSES!"
  end

  def display(board)
    display_board = board; i = 0
    while i < display_board.length
      if display_board[i].nil?
        display_board[i]= "_"
      end
      i += 1
    end
    puts display_board.join(" ")
  end


end



class HumanPlayer


  def register_secret_length(length)
    puts "The word is #{length} letters long."
  end

  def guess(board)
    puts "Guess a letter"
    gets.chomp
  end

  def handle_response(guess, response)
    puts "Found #{guess} at #{response} positions."
  end

  def pick_secret_word
    puts "Think of a secret word. How long is it?"
    gets.chomp
  end

  def check_guess(guess)
    puts "Player guessed #{guess}. What position does that occur at?"
    gets.chomp.split(",").map {|i_str| Integer(i_str)}
  end

  def require_secret
    puts "What word were you thinking of?"
    gets.chomp
  end

end

class ComputerPlayer

  def self.player_with_dict_file(dict_file_name)
    ComputerPlayer.new(File.readlines(dict_file_name).map(&:chomp))
  end

  attr_reader :dictionary, :secret_word, :candidate_words

  def initialize(dictionary)
   @dictionary = dictionary
  end

  def pick_secret_word
      @secret_word = @dictionary[Random.rand(@dictionary.length)]
      @secret_word.length
  end

  def check_guess(letter)
    matched = []
    i = 0
    while i < @secret_word.length
    matched << i if @secret_word[i] == letter
    i += 1
    end
     matched
  end

  def register_secret_length(length)
    @candidate_words = @dictionary.select { |word| word.length == length }
  end

  def guess(board)
    char_hash = Hash.new(0)
    @candidate_words.join.each_char do |char|
      char_hash[char] += 1
    end

    max_char = char_hash.key(char_hash.values.max)
    until board.include?(max_char) == false
      char_hash.delete(max_char)
      max_char = char_hash.key(char_hash.values.max)
    end
    max_char
  end

  def require_secret
    @secret_word
  end

  def handle_response(char, indices)
    if indices.empty?
      @candidate_words = @candidate_words.reject {|word| word.include?(char)}
    else
    indices.each do |index|
      @candidate_words = @candidate_words.select { |word| word[index] == char && word.count(char) == indices.length}
    end
   end
  end

end

if __FILE__ == $PROGRAM_NAME
  system('clear')

  print "Guesser: Computer (yes/no)? "
  if gets.chomp == "yes"
    guesser = ComputerPlayer.player_with_dict_file("dictionary.txt")
  else
    guesser = HumanPlayer.new
  end

  print "Referee: Computer (yes/no)? "
  if gets.chomp == "yes"
    referee = ComputerPlayer.player_with_dict_file("dictionary.txt")
  else
    referee = HumanPlayer.new
  end

  Hangman.new(guesser: guesser, referee: referee).play
end
