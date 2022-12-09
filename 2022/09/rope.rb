class Rope
  attr_accessor :knots

  def initialize(knots)
    @knots = knots
  end

  def move_head(direction, number)
    head = knots.first
    case direction
    when 'L'
      head[0] -= number
      move_knots
    when 'R'
      head[0] += number
      move_knots
    when 'U'
      head[1] += number
      move_knots
    when 'D'
      head[1] -= number
      move_knots
    else
      raise
    end
    @knots.last
  end

  def move_knots
    @knots.each_with_index do |knot, i|
      next if i == 0

      move_knot(@knots[i-1], knot)
    end
  end

  def move_knot(previous_knot, knot)
    return if previous_knot == knot

    horizontal_diff = previous_knot[0] - knot[0]
    vertical_diff = previous_knot[1] - knot[1]
    new_horizontal_diff = horizontal_diff
    new_vertical_diff = vertical_diff

    return if horizontal_diff.abs == 1 && vertical_diff.abs == 1

    if horizontal_diff.abs >= vertical_diff.abs
      if horizontal_diff > 0
        new_horizontal_diff -= 1
      else
        new_horizontal_diff += 1
      end
    end
    if horizontal_diff.abs <= vertical_diff.abs
      if vertical_diff > 0
        new_vertical_diff -= 1
      else
        new_vertical_diff += 1
      end
    end

    knot[0] += new_horizontal_diff
    knot[1] += new_vertical_diff
  end

  def pretty_print
    positions = knots.reduce({}) { |acc, r| acc[r] ||= knots.index(r); acc }

    min_x = positions.keys.map {|p| p[0]}.min - 1
    max_x = positions.keys.map {|p| p[0]}.max + 1
    min_y = positions.keys.map {|p| p[1]}.min - 1
    max_y = positions.keys.map {|p| p[1]}.max + 1

    (min_x .. max_x).each do |i|
      (min_y .. max_y).each do |j|
        if positions.keys.include?([i, j])
          print positions[[i, j]]
        else
          print '.'
        end
      end
      puts
    end
  end
end
