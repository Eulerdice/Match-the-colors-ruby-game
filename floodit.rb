# Public: Generates a randomly colored board for the game.
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
  colors = [ :red, :blue, :green, :yellow, :cyan, :magenta ]
  board = Array.new(height)
  (0..height-1).each do |i|
    board[i] = Array.new(width)
    (0..width-1).each do |j|
      board[i][j] = colors.sample
    end
  end
  return board
end
