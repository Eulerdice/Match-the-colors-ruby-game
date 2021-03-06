require 'console_splash'
require './floodit'

# Public: Creates a game frame with the specified width and height
#
# width - Integer representing the width of the game frame
# height - Integer representing the height of the game frame
#
# Example:
#
# splash = create_game_frame(30,40)
# => creates a fancy game frame with 40 rows and 30 columns
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
# Public: Clears the screen and resets the splash's text
#
# splash - ConsoleSplash object that represents the game frame
#
# Returns a splash object with no text inside
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

# Public: Displays the main menu and asks the user for input
#
# splash - ConsoleSplash object that represents the game frame
# best_score - Integer: The best score achieved on current game board Size
#
# Returns a symbol which represents the input from the user, which can be
# s,c or q.
def main_menu(splash,best_score)
  # Make sure game frame is empty
  splash = clear_game_screen(splash)

  splash.write_center(5,"Main Menu")
  splash.write_center(7,"s = Start Game")
  splash.write_center(8,"c = Change Size")
  splash.write_center(9,"q = Quit")
  if best_score[0] != -1
    splash.write_center(11,"Best Game: #{best_score[0]} turns")
  else
    splash.write_center(11,"No games have been played yet.")
  end
  splash.splash
  puts
  print "Enter your option: "
  return gets.chomp.to_sym
end

# Defaults and constants
FRAME_HEIGHT = 18
FRAME_WIDTH = 48
DEFAULT_COLUMNS = 14
DEFAULT_ROWS = 9

# Game init
best_score = [-1]
columns = DEFAULT_COLUMNS
rows = DEFAULT_ROWS
# Create and display the splash screen after clearing the screen
system "clear" or system "cls"
splash = create_game_frame(FRAME_WIDTH,FRAME_HEIGHT)
display_splash_screen(splash)
# Game loop untill player exits
loop do
  # Main menu that connects all the pieces together
  case main_menu(splash,best_score)
  when :s then start_game(columns, rows, best_score)
  when :c
    print "Width(Currently #{columns})?"
    input = gets.chomp
    next if input.to_sym == :q
    columns = input.to_i
    # Reset best score since game board changed sizes
    best_score[0] = -1

    print "Height(Currently #{rows})?"
    input = gets.chomp
    next if input.to_sym == :q
    rows = input.to_i
  when :q
    system "clear" or system "cls"
    exit
  end
end
