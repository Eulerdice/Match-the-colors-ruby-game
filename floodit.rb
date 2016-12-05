require 'console_splash'
require './launcher'

# Public: Creates a randomly colored board for the game.
#
# width - Integer which represents the board's width
# height - Integer which represents the board's height
#
# Example:
#
# get_board(2,2)  # => [[green,red],[cyan,blue]]
#
# Returns a 2d array with random colour symbols
def get_board(width, height)
  #array with all possible colors
  colors = [:red, :blue, :green, :yellow, :cyan, :magenta]

  board = Array.new(height)
  (0..height-1).each do |i|
    board[i] = Array.new(width)
    (0..width-1).each do |j|
      board[i][j] = colors.sample
    end
  end

  return board
end

# Public: Checks if the argument is a valid color
#
# input - symbol : a single letter
#
# Example:
#
# is_a_color?(:b) # => true
#
# Returns true if the color is valid and false otherwise
def is_a_color?(input)
  return  input == :r ||
          input == :b ||
          input == :g ||
          input == :y ||
          input == :c ||
          input == :m
end

def update(board, player_color, input, current_completition, x, y)
  board[x][y] = input
  current_completition += 1
  if board[x + 1][y] == player_color
    update(board, player, input, current_completition, x + 1, y)
  if board[x][y + 1] == player_color
    update(board, player, input, current_completition, x, y + 1)
end

def display_board(board, splash)
end

#begin WORK IN PROGRESS
def start_game(columns,rows,splash)
  #init
  board = get_board(columns,rows)
  turns = 0
  current_completition = 0
  player_color = board[0][0]

  loop do
    clear_game_screen()
    display_board(board)
    puts "Number of turns: #{turns}"
    puts "Current completition:
                        #{current_completition*100/board.columns*board.rows}%"
    print "Choose a color: "
    input = gets.chomp.to_sym
    if is_a_color?(input)
      current_completition = 0
      board = update(board, player_color, input, current_completition)
      turns += 1
      player_color = input
    elsif input == :q
      break
    else
      print "Invalid input, please select a valid color or quit."
    end

    break if is_over(board) == false
  end
end
#end


# 1.Create new board
# 2.Display number of turns, % completed and ask for user input r,g,b,y,m,c
# 3.Check if game_is_won
# 3.1.If yes check if number of turns > high Score
# 3.1.1.If yes update high Score
# 3.2.If not check if user input is valid(color is in range and color exists)
# 3.2.1. If yes,
