#! /usr/bin/env ruby

input = File.read('16-input.txt')
#input = <<EOF
#.|...\\....
#|.-.\\.....
#.....|-...
#........|.
#..........
#.........\\
#..../.\\\\..
#.-.-/..|..
#.|....-|.\\
#..//.|....
#EOF
input = input.split("\n").map {|l| l.split('')}


def move(row, column, direction, input)
  new_item = false
  case direction
  when :up
    if row > 0
      new_item = [row-1, column, direction]
    end
  when :down
    if row < input.length-1
      new_item = [row+1, column, direction]
    end
  when :left
    if column > 0
      new_item = [row, column-1, direction]
    end
  when :right
    if column < input.first.length-1
      new_item = [row, column+1, direction]
    end
  end
  new_item
end

def pretty_print(input)
  input.each_with_index do |line, row|
    line.each_with_index do |tile, column|
      if @energised_tiles.include?([row, column])
        print '#'
      else
        print '.'
      end
    end
    puts
  end
  nil
end

def run(row, column, direction, input)
  @queue = Queue.new
  @queue.push([row, column, direction])

  @energised_tiles = Set.new
  @energised_tiles << [row, column]
  @visited = Set.new
  @visited << [row, column, direction]

  loop do
    row, column, direction = @queue.pop

    new_items = []
    case input[row][column]
    when '/'
      case direction
      when :right
        new_items << move(row, column, :up, input)
      when :up
        new_items << move(row, column, :right, input)
      when :down
        new_items << move(row, column, :left, input)
      when :left
        new_items << move(row, column, :down, input)
      end
    when '\\'
      case direction
      when :right
        new_items << move(row, column, :down, input)
      when :up
        new_items << move(row, column, :left, input)
      when :down
        new_items << move(row, column, :right, input)
      when :left
        new_items << move(row, column, :up, input)
      end
    when '-'
      case direction
      when :right
        new_items << move(row, column, :right, input)
      when :up
        new_items << move(row, column, :left, input)
        new_items << move(row, column, :right, input)
      when :down
        new_items << move(row, column, :left, input)
        new_items << move(row, column, :right, input)
      when :left
        new_items << move(row, column, :left, input)
      end
    when '|'
      case direction
      when :right
        new_items << move(row, column, :down, input)
        new_items << move(row, column, :up, input)
      when :up
        new_items << move(row, column, :up, input)
      when :down
        new_items << move(row, column, :down, input)
      when :left
        new_items << move(row, column, :down, input)
        new_items << move(row, column, :up, input)
      end
    else
      new_items << move(row, column, direction, input)
    end

    if new_items.any?
      new_items.each do |new_item|
        next if new_item == false

        #pretty_print(input)
        #puts
        break if @visited.include?(new_item)

        @queue.push(new_item)
        @visited << new_item
        @energised_tiles << new_item[0..1]
      end
    end

    break if @queue.empty?
  end
  @energised_tiles.size
end

all_energised_tiles = []
(0 .. input.length-1).each do |row|
  all_energised_tiles << run(row, 0, :right, input)
end

(0 .. input.length-1).each do |row|
  all_energised_tiles << run(row, input.first.length-1, :left, input)
end

(0 .. input.first.length-1).each do |column|
  all_energised_tiles << run(0, column, :down, input)
end

(0 .. input.first.length-1).each do |column|
  all_energised_tiles << run(input.length-1, column, :up, input)
end

puts all_energised_tiles.max
