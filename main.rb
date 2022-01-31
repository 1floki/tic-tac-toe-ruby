# frozen_string_literal: true

class Player
  attr_reader :name, :symbol

  def initialize(symbol)
    puts "Enter player name for the symbol: #{symbol}"
    @name = gets.chomp
    @symbol = symbol
  end
end

class Game
  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @players = [@player_one, @player_two]
  end

  @winner_declared = false

  def display
    # puts display of board with current available options
    @display = "\n#{@board[0]} | #{@board[1]} | #{@board[2]} \n---------\n#{@board[3]} | #{@board[4]} | #{@board[5]} \n---------\n#{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def play
    @board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    @times_board_enteries_replace = 0
    @current_player = 0

    until @winner_declared
      puts "#{@players[@current_player].name}'s turn (#{@players[@current_player].symbol}). Please choose one from the available options.\nNote: Non-integer values will be evaluated to 0.\n"
      puts display
      loop do
        selection = gets.chomp.to_i
        if @board.include?(selection)
          puts "You selected #{selection}.\n\n"
          @board[selection] = @players[@current_player].symbol
          @times_board_enteries_replace += 1
          break
        else
          puts 'Invalid input. Try again'
        end
      end

      if (@board[0].eql?(@board[1]) && @board[1].eql?(@board[2])) ||
         (@board[3].eql?(@board[4]) && @board[4].eql?(@board[5])) ||
         (@board[6].eql?(@board[7]) && @board[7].eql?(@board[8])) ||
         (@board[0].eql?(@board[3]) && @board[3].eql?(@board[6])) || # rows start here
         (@board[1].eql?(@board[4]) && @board[4].eql?(@board[7])) ||
         (@board[2].eql?(@board[5]) && @board[5].eql?(@board[8])) ||
         (@board[0].eql?(@board[4]) && @board[4].eql?(@board[8])) || # diagnonal checking
         (@board[2].eql?(@board[4]) && @board[4].eql?(@board[6]))
        puts display
        puts "#{@players[@current_player].name} won!"
        @winner_declared = true
      elsif @times_board_enteries_replace == 9
        puts display
        puts "It's a draw!"
        @winner_declared = true
      end

      @current_player = (@current_player + 1) % 2

    end
  end
end

pone = Player.new(:X)
ptwo = Player.new(:O)

game = Game.new(pone, ptwo)

game.play
