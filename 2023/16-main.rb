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

@queue = Queue.new
@queue.push([0, 0, :right])

@energised_tiles = Set.new
@energised_tiles << [0, 0]

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

  if new_item
    @queue.push(new_item)
    @energised_tiles << new_item[0..1]
    puts @energised_tiles.size if rand(1_000_000) == 0
    #pretty_print(input)
    #puts
    #sleep(1)
  #else
  #  puts "Out of bounds"
  end
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

loop do
  row, column, direction = @queue.pop

  case input[row][column]
  when '/'
    case direction
    when :right
      move(row, column, :up, input)
    when :up
      move(row, column, :right, input)
    when :down
      move(row, column, :left, input)
    when :left
      move(row, column, :down, input)
    end
  when '\\'
    case direction
    when :right
      move(row, column, :down, input)
    when :up
      move(row, column, :left, input)
    when :down
      move(row, column, :right, input)
    when :left
      move(row, column, :up, input)
    end
  when '-'
    case direction
    when :right
      move(row, column, :right, input)
    when :up
      move(row, column, :left, input)
      move(row, column, :right, input)
    when :down
      move(row, column, :left, input)
      move(row, column, :right, input)
    when :left
      move(row, column, :left, input)
    end
  when '|'
    case direction
    when :right
      move(row, column, :down, input)
      move(row, column, :up, input)
    when :up
      move(row, column, :up, input)
    when :down
      move(row, column, :down, input)
    when :left
      move(row, column, :down, input)
      move(row, column, :up, input)
    end
  else
    move(row, column, direction, input)
  end

  break if @queue.empty?
end

# TODO: it doesn't actually stop, ever
