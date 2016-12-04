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

# Public: Creates a game frame with the specified width and height
#
# width - Integer representing the width of the game frame
# height - Integer representing the height of the game frame
#
# Example:
#
#   splash = create_game_frame(30,40)
#   => creates a fancy game frame with 40 rows and 30 columns
#
# Returns the splash object, a game frame with no text inside
def create_game_frame(width,height)
  splash = ConsoleSplash.new(height, width)

  #Surrounding the game frame with fancy stylized symbols
  splash.write_horizontal_pattern("~-~", {:fg=>:red, :bg=>:white})
  splash.write_left_pattern("<", {:fg=>:red, :bg=>:white})
  splash.write_right_pattern(">", {:fg=>:red, :bg=>:white})

  return splash
end
# Public: Clears the screen and resets the splash object's text
#
# splash - ConsoleSplash object that represents the game frame
#
# Returns a splash object, a game frame with no text inside
def clear_game_screen(splash)
  system "clear" or system "cls"
  new_splash = create_game_frame(splash.columns,splash.lines)
  return new_splash
end

# Public: Displays a splash screen for the game
#
# width - Integer measurement unit for the splash screen's width
# height - Integer measurement unit for the splash screen's height
#
# Returns nothing
def display_splash_screen(splash)
  #Game general information
  splash.write_header(" Flood it !", "Alex Bondrea", "1.0", {:nameFg=>:white,
                                                             :nameBg=>:blue})
  splash.write_center(-2, "Copyright © 2016 Alex Bondrea")

  splash.splash # => render splash screen
  gets # => Exit splash when user input
end

# Public: Displays the main menu of the game and redirects the user to the
#         correct game function based on his input.
#
# splash - ConsoleSplash object that represents the game frame
#
# Returns nothing
def main_menu(splash)
  splash.write_center(5,"Main Menu")
  splash.write_center(7,"s = Start Game")
  splash.write_center(8,"c = Change Size")
  splash.write_center(9,"q = Quit")

  splash.splash
  puts
  print "Enter your option: "
  option = gets.chomp.to_sym
  case option
  when :s then start_game
  when :c then change_size
  when :q then puts
  end
end

#testing
height = 18
width = 48
splash = create_game_frame(width,height)
system "clear" or system "cls"
display_splash_screen(splash)
splash = clear_game_screen(splash)
main_menu(splash)
