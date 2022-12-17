class Shape
  def try_down
    @points.map do |x, y|
      [x, y-1]
    end
  end

  def try_left
    @points.map do |x, y|
      [x-1, y]
    end
  end

  def try_right
    @points.map do |x, y|
      [x+1, y]
    end
  end

  def set_position(points)
    @points = points
  end
  def position; @points; end
end

# ####
class HLine < Shape
  def initialize(y)
    @points = [
      [2, y],
      [3, y],
      [4, y],
      [5, y],
    ]
  end
end

# .#.
# ###
# .#.
class Cross < Shape
  def initialize(y)
    @points = [
      [3, y+2],
      [2, y+1],
      [3, y+1],
      [4, y+1],
      [3, y],
    ]
  end
end

# ..#
# ..#
# ###
class Shelf < Shape
  def initialize(y)
    @points = [
      [4, y+2],
      [4, y+1],
      [2, y],
      [3, y],
      [4, y],
    ]
  end
end

# #
# #
# #
# #
class VLine < Shape
  def initialize(y)
    @points = [
      [2, y+3],
      [2, y+2],
      [2, y+1],
      [2, y],
    ]
  end
end

# ##
# ##
class Square < Shape
  def initialize(y)
    @points = [
      [2, y+1],
      [3, y+1],
      [2, y],
      [3, y],
    ]
  end
end
