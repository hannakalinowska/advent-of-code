class Elf
  attr_reader :elf_id

  def initialize(x, y)
    @x = x
    @y = y
    @proposed_move = nil
  end

  def to_s
    "Elf #{@elf_id} [#{@x}, #{@y}]"
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

  def proposed_move(elves, direction_order)
    return if all_alone?(elves)

    moves = {
      'N' => [@x-1, @y],
      'S' => [@x+1, @y],
      'E' => [@x, @y+1],
      'W' => [@x, @y-1],
    }

    positions = elves.map(&:position)

    direction_order.each do |direction|
      neighbours = neighbours(@x, @y, direction)
      if neighbours.none?{|m| positions.include?(m)}
        @proposed_move = moves[direction]
        break
      end
    end
    @proposed_move
  end

  def position
    [@x, @y]
  end

  def commit
    raise "No proposed move" if @proposed_move.nil?

    @x = @proposed_move.first
    @y = @proposed_move.last

    @proposed_move = nil
  end

  def cancel
    @proposed_move = nil
  end

  def all_alone?(elves)
    north_move?(elves) && south_move?(elves) && east_move?(elves) && west_move?(elves)
  end

  def east_move?(elves)
    positions = elves.map(&:position)

    moves = neighbours(@x, @y, 'E')

    moves.none?{|m| positions.include?(m)}
  end

  def west_move?(elves)
    positions = elves.map(&:position)

    moves = neighbours(@x, @y, 'W')

    moves.none?{|m| positions.include?(m)}
  end

  def south_move?(elves)
    positions = elves.map(&:position)

    moves = neighbours(@x, @y, 'S')

    moves.none?{|m| positions.include?(m)}
  end

  def north_move?(elves)
    positions = elves.map(&:position)

    moves = neighbours(@x, @y, 'N')

    moves.none?{|m| positions.include?(m)}
  end
end

