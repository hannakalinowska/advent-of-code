class Tile
  attr_reader :i, :j

  def initialize(i, j, input, previous = nil)
    @i = i
    @j = j
    @input = input
    @previous = previous
  end

  def follow
    case input[i][j]
    when '|'
      if @previous.j == @j-1
        new(i, @j+1, @input, self)
      else
        new(i, @j-1, @input, self)
      end
    when '-'
      if @previous.i == @i-1
        new(@i+1, @j, @input, @previous)
      else
        new(@i-1, @j, @input, @previous)
      end
    when 'L'
      if @previous.i == @i
        new(@i+1, @j, @input, @previous)
      else
        new(@i, @j+1, @input, @previous)
      end
    when 'J'
      if @previous.i == @i
        new(@i+1, @j, @input, @previous)
      else
        new(@i, @j-1, @input, @previous)
      end
    when '7'
    when 'F'
    when 'S'
    end
  end

  def ==(tile)
    @i == tile.i && @j == tile.j
  end
end

