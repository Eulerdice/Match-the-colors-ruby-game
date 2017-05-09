require 'console_splash'
require 'colorize'
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
# color - symbol : the name of a color
#
# Examples:
#
# is_a_color?(:blue) # => true
# is_a_color?(:xax) # => false
#
# Returns true if the color is in {:red, :blue, :green, :yellow, :cyan, :magenta}
def is_a_color?(color)
  return  color == :red ||
          color == :blue ||
          color == :green ||
          color == :yellow ||
          color == :cyan ||
          color == :magenta
end

# Public: Changes the state of the board based on given color
#
# board - 2D Array of symbols that represents the board state
# player_color - symbol of colour, currently owned by the player
# input_color - symbol of colour, input from the player
# x and y - Integers representing the coordinates of the player's starting
#                                                                    point
#
# Example:
#
#  update(board, :red, :blue, 0, 0)
#  => changes all the player owned squares' color in blue starting from top
#                                                                left corner
#
# returns 2D Array of symbols that represents the board state
def update(board, player_color, input_color, x, y)
  board[x][y] = input_color
  # Recursively call the function for all nearby positions
  if x < board.length - 1 && board[x + 1][y] == player_color
    update(board, player_color, input_color, x + 1, y)
  end
  if y < board[x].length - 1 && board[x][y + 1] == player_color
    update(board, player_color, input_color, x, y + 1)
  end
  if x > 0 && board[x - 1][y] == player_color
    update(board, player_color, input_color, x - 1, y)
  end
  if y > 0 && board[x][y - 1] == player_color
    update(board, player_color, input_color, x, y - 1)
  end

  return board
end

# Public: Displays a matrix of colored squares
#
# board - 2D Array of symbols that represents the board state
#
# Returns nothing
def display_board(board)
  (0..board.length - 1).each do |i|
    (0..board[i].length - 1).each do |j|
      print "  ".colorize(:background => board[i][j])
    end
    puts
  end
end
# Public: Counts the number of times a color appears in the game board
#
# board - 2D Array of symbols that represents the board state
# color - Symbol representing a valid color
#
# Example:
#
#  color_in_board(board, :blue) # => 4
#
# Returns an integer : the number of appearances of color in board[][]
def color_in_board(board, color)
  counter = 0

  board.each do |array|
    array.each do |element|
      counter += 1 if color == element
    end
  end

  return counter
end

# Public: Checks if the game is finished
#
# board - 2D Array of symbols that represents the board state
#
# Returns false if the game is over and true otherwise
def is_over?(board)
  # if board has more than one row, compare rows
  if board.length > 1
    (0..board.length - 2).each do |element|
      #in case any 2 arrays are not equal, the game is not over
      return false if board[element] != board[element + 1]
    end
  # else compare each element on the single row
  else
    (0..board[0].length - 2).each do |element|
      return false if board[0][element] != board[0][element + 1]
    end
  end
  #all elements are equal therefore the game is over
  return true
end

# Public: Converts color initial to full color name
#
# input_color - Symbol single letter representing an initial for a valid color
#
# Example:
#
#  auto_complete_color(:r) # => :red
#
# Returns a color symbol from {:red, :blue, :green, :yellow, :cyan, :magenta}
#         or :quit
def auto_complete(input_color)
  case input_color
  when :b then return :blue
  when :r then return :red
  when :g then return :green
  when :y then return :yellow
  when :c then return :cyan
  when :m then return :magenta
  when :q then return :quit
  end
end

# Public: Function to start a game of flood-it
#
# columns - Integer : the number game board's columns
# rows - Integer : the number of game board's rows
# best_score - Integer : player's current best score
#
# Returns nothing
def start_game(columns, rows, best_score)
  #init
  board = get_board(columns,rows)
  turns = 0
  player_color = board[0][0]
  # Gameplay loop untill the board has only one color
  loop do
    system "clear" or system "cls"
    display_board(board)
    puts "Number of turns: #{turns}"
    current_completion = color_in_board(board,player_color)*100/(columns*rows).to_f
    puts "Current completion: #{current_completion.to_i}%"
    # Check if the game is over
    if is_over?(board)
      if best_score[0] == -1
        best_score[0] = turns
      else
        best_score[0] = [best_score[0], turns].min
      end
      puts "You won after #{turns} turns"
      gets
      system "clear" or system "cls"
      break
    end
    # Take user's input and update the board respectively
    puts "Possible inputs: q for quit, r for red/ b for blue/ g for green/ y for yellow/ c for cyan/ m for magenta"
    print "Choose a color: "
    input = auto_complete(gets.chomp.to_sym)
    if is_a_color?(input) && input != player_color
      board = update(board, player_color, input, 0, 0)
      turns += 1
      player_color = input
    elsif input == :quit
      break
    end
  end
end
