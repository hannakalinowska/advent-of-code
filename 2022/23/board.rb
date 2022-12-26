class Board
  attr_accessor :elves

  def initialize
    @positions = nil
  end

  def positions
    @positions ||= elves.map(&:position)
  end

  def commit
    @positions = nil
  end

  def neighbours(x, y, direction)
    moves = []
    case direction
    when 'N'
      moves << [x-1, y-1]
      moves << [x-1, y]
      moves << [x-1, y+1]
    when 'S'
      moves << [x+1, y-1]
      moves << [x+1, y]
      moves << [x+1, y+1]
    when 'E'
      moves << [x-1, y+1]
      moves << [x, y+1]
      moves << [x+1, y+1]
    when 'W'
      moves << [x-1, y-1]
      moves << [x, y-1]
      moves << [x+1, y-1]
    end
    moves
  end

  def north_move?(x, y)
    move?(x, y, 'N')
  end

  def east_move?(x, y)
    move?(x, y, 'E')
  end

  def west_move?(x, y)
    move?(x, y, 'W')
  end

  def south_move?(x, y)
    move?(x, y, 'S')
  end

  def move?(x, y, direction)
    moves = neighbours(x, y, direction).map {|x, y| 1_000_000 * x + y}
    moves.none? {|m| positions.include?(m)}
  end
end
