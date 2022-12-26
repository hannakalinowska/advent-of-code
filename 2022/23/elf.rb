class Elf
  attr_reader :elf_id

  def initialize(x, y, board: nil)
    @x = x
    @y = y
    @board = board
    @proposed_move = nil
    @neighbours = {}
  end

  def to_s
    "Elf #{@elf_id} [#{@x}, #{@y}]"
  end


  def proposed_move(elves, direction_order)
    return if all_alone?

    moves = {
      'N' => [@x-1, @y],
      'S' => [@x+1, @y],
      'E' => [@x, @y+1],
      'W' => [@x, @y-1],
    }

    direction_order.each do |direction|
      neighbours = @board.neighbours(@x, @y, direction).map {|x, y| 1_000_000 * x + y}
      if neighbours.none?{|m| @board.positions.include?(m)}
        @proposed_move = moves[direction]
        break
      end
    end
    @proposed_move
  end

  def position
    1_000_000 * @x + @y
  end

  def commit
    raise "No proposed move" if @proposed_move.nil?

    @x = @proposed_move.first
    @y = @proposed_move.last

    @proposed_move = nil
    @neighbours = {}
  end

  def cancel
    @proposed_move = nil
  end

  def all_alone?
    @board.north_move?(@x, @y) && @board.south_move?(@x, @y) && @board.east_move?(@x, @y) && @board.west_move?(@x, @y)
  end
end

