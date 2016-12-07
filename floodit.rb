require 'console_splash'
require 'colorize'
require 'colorized_string'
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

# Public: Checks if the argument is the initial of a valid color
#
# color - symbol : a single letter
#
# Examples:
#
# is_a_color?(:b) # => true
# is_a_color?(:x) # => false
#
# Returns true if the color is from {:r, :b, :g, :y, :c, :m}
def is_a_color?(color)
  return  color == :r ||
          color == :b ||
          color == :g ||
          color == :y ||
          color == :c ||
          color == :m
end

# Public: Changes the state of the board based on given color
# 
# board - 2D Array of symbols that represents the board state
# player_color - symbol of colour, currently owned by the player
# input_color - symbol of colour, input from the player
# x and y - Integers representing the coordinates of the top left corner(always called with 0, 0)
# 
# Example:
# 
#  update(board, :red, :blue, 0, 0)
#  => changes all the player owned squares' red sqares in blue squares
#  
# returns nothing
def update(board, player_color, input_color, x, y)
  board[x][y] = input_color
  if board[x + 1][y] == player_color
    update(board, player_color, input_color, x + 1, y)
  end
  if board[x][y + 1] == player_color
    update(board, player_color, input_color, x, y + 1)
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
            #buffer = j + splash.columns/2 -board[i].length
            print "██".colorize(:color => board[i][j], :background => board[i][j])
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
    (0..board.length - 2).each do |element|
        return false if board[element] != board[element + 1]
    end
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
def auto_complete_color(input_color)
    return :blue if input_color == :b
    return :red if input_color == :r
    return :green if input_color == :g
    return :yellow if input_color == :y
    return :cyan if input_color == :c
    return :magenta if input_color == :m
end

#begin WORK IN PROGRESS
def start_game(columns, rows)
  #init
  board = get_board(columns,rows)
  turns = 0
  player_color = board[0][0]
  current_completition = color_in_board(board,player_color)

  loop do
    system "clear" or system "cls"
    display_board(board)
    puts "Number of turns: #{turns}"
    puts "Current completition: #{current_completition/(columns*rows)*100}%"
    print "Choose a color: "
    input = gets.chomp.to_sym
    if is_a_color?(input)
      input = auto_complete_color(input)
      current_completition = color_in_board(board, input)
      board = update(board, player_color, input, 0, 0)
      turns += 1
      player_color = input
    elsif input == :q
      break
    else
      print "Invalid input, please select a valid color or quit."
    end
    
    break if is_over?(board)
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
