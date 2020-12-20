class Board
  attr_accessor :tiles, :size, :positions

  def initialize(tiles, positions = nil)
    @tiles = tiles
    @size = Math.sqrt(@tiles.map(&:id).uniq.length)
    @positions = positions || Array.new(size) {Array.new(size)}
  end

  def free_tiles
    ids = positions.flatten.map {|p| p&.id }
    tiles.select {|t| !ids.include?(t.id) }
  end

  def valid?
    if positions.flatten.compact.count != @size * @size
      return false
    end

    positions.each.with_index do |row, i|
      row.each.with_index do |tile, j|
        right_neighbour = positions[i][j + 1]
        bottom_neighbour = positions[i + 1] && positions[i + 1][j]

        result = right_neighbour ? tile.right_border == right_neighbour.left_border : true
        return false if result == false

        result = bottom_neighbour ? tile.bottom_border == bottom_neighbour.top_border : true
        return false if result == false
      end
    end
    true
  end

  def start
    tiles.each.with_index do |t, iteration|
      puts iteration
      positions[0][0] = t
      board = self.solve
      return board if board
    end
    return false
  end

  def solve
    new_positions = Array.new(size)
    positions.each.with_index do |row, i|
      new_positions[i] ||= []
      row.each.with_index do |tile, j|
        new_positions[i][j] = tile
      end
    end

    (0 .. size - 1).each do |i|
      (0 .. size - 1).each do |j|
        next if new_positions[i][j]

        top_neighbour = i > 0 ? new_positions[i - 1][j] : nil
        right_neighbour = j < size - 1 ? new_positions[i][j + 1] : nil
        bottom_neighbour = i < size - 1 ? new_positions[i + 1][j] : nil
        left_neighbour = j > 0 ? new_positions[i][j - 1] : nil

        matching_top = free_tiles.select {|t| t.top_border == top_neighbour.bottom_border} rescue free_tiles
        matching_right = free_tiles.select {|t| t.right_border == right_neighbour.left_border} rescue free_tiles
        matching_bottom = free_tiles.select {|t| t.bottom_border == bottom_neighbour.top_border} rescue free_tiles
        matching_left = free_tiles.select {|t| t.left_border == left_neighbour.right_border} rescue free_tiles
        total_matching = matching_top & matching_right & matching_bottom & matching_left
        if total_matching.size == 1
          new_positions[i][j] = total_matching.first
          board = Board.new(tiles, new_positions).solve
          if board
            positions[i][j] = total_matching.first
          end
          return board
        elsif total_matching.size == 0
          return false
        else
          total_matching.each do |m|
            new_positions[i][j] = m
            board = Board.new(tiles, new_positions).solve
            if board
              positions[i][j] = total_matching.first
            end
            return board
          end
        end
      end
    end
    return valid? ? self : false
  end
end
