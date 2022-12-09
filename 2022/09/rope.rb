class Rope
  attr_accessor :head, :tail

  def initialize(head, tail)
    @head = head
    @tail = tail
  end

  def move_head(direction, number)
    case direction
    when 'L'
      @head = [@head[0]-number, @head[1]]
      move_tail
    when 'R'
      @head = [@head[0]+number, @head[1]]
      move_tail
    when 'U'
      @head = [@head[0], @head[1]+number]
      move_tail
    when 'D'
      @head = [@head[0], @head[1]-number]
      move_tail
    else
      raise
    end
  end

  def move_tail
    return @tail if @head == @tail

    horizontal_diff = @head[0] - @tail[0]
    vertical_diff = @head[1] - @tail[1]

    return @tail if horizontal_diff.abs == 1 && vertical_diff.abs == 1

    if horizontal_diff.abs > vertical_diff.abs
      if horizontal_diff > 0
        horizontal_diff -= 1
      else
        horizontal_diff += 1
      end
    else
      if vertical_diff > 0
        vertical_diff -= 1
      else
        vertical_diff += 1
      end
    end

    @tail = [@tail[0]+horizontal_diff, @tail[1]+vertical_diff]
    @tail
  end
end
