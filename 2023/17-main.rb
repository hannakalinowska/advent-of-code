#! /usr/bin/env ruby

input = File.read('17-input.txt')
input = <<EOF
2413432311323
3215453535623
3255245654254
3446585845452
4546657867536
1438598798454
4457876987766
3637877979653
4654967986887
4564679986453
1224686865563
2546548887735
4322674655533
EOF
INPUT = input.split("\n").map {|l| l.split('').map(&:to_i)}

start = [0, 0]
finish = [INPUT.length-1, INPUT.first.length-1]
min_heat_losses = {}
min_paths = {}

def expand(path)
  paths = []
  loop do
    paths.unshift(path)
    path = path.previous_path

    break if path.nil?
  end
  paths
end

class Path
  attr_reader :row, :column, :heat_loss, :straight_line_count, :previous_path

  def initialize(row, column, previous_path, heat_loss, straight_line_count)
    @row = row
    @column = column
    @previous_path = previous_path
    @heat_loss = heat_loss
    @straight_line_count = straight_line_count
  end

  def forward
    return @forward if defined?(@forward)
    return nil unless forward_coords

    @forward = Path.new(
      forward_coords.first,
      forward_coords.last,
      self,
      self.heat_loss + INPUT[forward_coords.first][forward_coords.last],
      straight_line_count + 1
    )
  end

  def left
    return @left if defined?(@left)
    return nil unless left_coords

    new_heat_loss = INPUT[left_coords.first][left_coords.last]
    new_heat_loss += self.heat_loss

    @left = Path.new(
      left_coords.first,
      left_coords.last,
      self,
      new_heat_loss,
      1
    )
  end

  def right
    return @right if defined?(@right)
    return nil unless right_coords

    new_heat_loss = INPUT[right_coords.first][right_coords.last]
    new_heat_loss += self.heat_loss

    @right = Path.new(
      right_coords.first,
      right_coords.last,
      self,
      new_heat_loss,
      1
    )
  end

  def possible_moves
    moves = [
      [@row, @column-1],
      [@row, @column+1],
      [@row-1, @column],
      [@row+1, @column],
    ]
    moves = moves.select {|m| m.first >= 0 && m.first < INPUT.length && m.last >= 0 && m.last < INPUT.first.length}
    moves = moves - [@previous_path.coords] if @previous_path
    moves
  end

  def coords
    [@row, @column]
  end

  def forward_coords
    return [] unless @previous_path

    @forward_coords ||= possible_moves.find {|m| m.first == @previous_path.row || m.last == @previous_path.column}
  end

  def left_coords
    @left_coords ||= (possible_moves - [forward_coords]).first
  end

  def right_coords
    @right_coords ||= (possible_moves - [forward_coords] - [left_coords]).first
  end
end

def pretty_print(path)
  fields = expand(path).map {|p| p.coords}
  INPUT.each_with_index do |line, row|
    line.each_with_index do |c, column|
      if fields.include?([row, column])
        print '.'
      else
        print c
      end
    end
    puts
  end
end

start_path = Path.new(0, 0, nil, 0, 1)

queue = Queue.new
queue.push(start_path.left)
queue.push(start_path.right)

loop do
  path = queue.pop
  if min_heat_losses[[path.row, path.column]].nil? ||
      min_heat_losses[[path.row, path.column]] > path.heat_loss
    min_heat_losses[[path.row, path.column]] = path.heat_loss
    min_paths[[path.row, path.column]] = path

    #puts "Current: #{path.coords} Total heat loss: #{path.heat_loss}"
    #puts "Forward: #{path.forward.coords} Field heat loss: #{INPUT[path.forward.row][path.forward.column]}, Total: #{path.forward.heat_loss}"
    #puts "Left: #{path.left.coords} Field heat loss: #{INPUT[path.left.row][path.left.column]}, Total: #{path.left.heat_loss}"
    #puts "Right: #{path.right.coords} Field heat loss: #{INPUT[path.right.row][path.right.column]}, Total: #{path.right.heat_loss}" if path.right
    #require 'pry'; binding.pry
    # move left
    queue.push(path.left) if path.left

    # move right
    queue.push(path.right) if path.right

    # move forward
    if path.straight_line_count < 3
      queue.push(path.forward) if path.forward
    end
  end

  break if queue.empty?
end

pretty_print(min_paths[finish])
puts min_heat_losses[finish]

require 'pry'; binding.pry
puts
