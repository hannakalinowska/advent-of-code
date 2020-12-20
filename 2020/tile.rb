class Tile
  attr_accessor :id, :tile

  def initialize(id, tile)
    @id = id
    @tile = tile
  end

  def flip_horizontally
    Tile.new(id, tile.map(&:reverse))
  end

  def flip_vertically
    Tile.new(id, tile.reverse)
  end

  def rotate
    new_tile = []
    tile.each.with_index do |row, i|
      length = row.length
      row.split('').each.with_index do |t, j|
        new_tile[j] ||= []
        new_tile[j][length - i - 1] = t
      end
    end
    new_tile = new_tile.map {|t| t.join}
    Tile.new(id, new_tile)
  end

  def right_border
    tile.map {|t| t[-1]}.join
  end

  def left_border
    tile.map {|t| t[0]}.join
  end

  def top_border
    tile.first
  end

  def bottom_border
    tile.last
  end
end
