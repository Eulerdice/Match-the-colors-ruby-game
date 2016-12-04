require 'console_splash'

# Public: Creates a randomly colored board for the game.
#
# width - Integer which represents the board's width
# height - Integer which represents the board's height
#
# Example:
#
#    get_board(2,2)  # => [[green,red],[cyan,blue]]
#
# Returns a 2d array with random colour symbols
def get_board(width, height)
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

# Public: Displays a splash screen for the game
#
# width - Integer measurement unit for the splash screen's width
# height - Integer measurement unit for the splash screen's height
#
# Returns nothing
def display_splash(width, height)
  splash = ConsoleSplash.new(height, width)
  #Game general information
  splash.write_header(" Flood it ! ", "Alex Bondrea", "1.0")
  splash.write_center(-2, "Copyright © 2016 Alex Bondrea")
  #Surrounding the game window
  splash.write_horizontal_pattern("~-~")
  splash.write_left_pattern("<<")
  splash.write_right_pattern(">>")

  splash.splash # => render splash screen
  gets() # => Exit splash when user input
end
