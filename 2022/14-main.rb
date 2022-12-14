#! /usr/bin/env ruby

require 'set'

input = File.read('14-input.txt')
#input = <<-EOF
#498,4 -> 498,6 -> 496,6
#503,4 -> 502,4 -> 502,9 -> 494,9
#EOF
input = input.split("\n")

rocks = Set.new

input.each do |line|
  points = line.split(' -> ')
  points[0 .. -2].each_with_index do |start, index|
    finish = points[index+1]
    start_x, start_y = start.split(',').map(&:to_i)
    finish_x, finish_y = finish.split(',').map(&:to_i)

    Range.new(*([start_x, finish_x].sort)).each do |x|
      Range.new(*([start_y, finish_y].sort)).each do |y|
        rocks << [x, y]
      end
    end
  end
end

def empty_below?(rocks, sand)
  !rocks.include?([sand[0], sand[1]+1])
end

def empty_below_left?(rocks, sand)
  !rocks.include?([sand[0]-1, sand[1]+1])
end

def empty_below_right?(rocks, sand)
  !rocks.include?([sand[0]+1, sand[1]+1])
end

def floor_below?(floor, sand)
  sand[1]+1 == floor
end

# Where are the lowest rocks?
floor = rocks.map(&:last).max + 2

# sand falls
sand_count = 0
loop do
  sand = [500, 0]
  loop do
    #puts sand_count
    if floor_below?(floor, sand)
      rocks << sand
      sand_count += 1
      break
    end
    if empty_below?(rocks, sand)
      sand = [sand[0], sand[1]+1]
    elsif empty_below_left?(rocks, sand)
      sand = [sand[0]-1, sand[1]+1]
    elsif empty_below_right?(rocks, sand)
      sand = [sand[0]+1, sand[1]+1]
    else
      # nowhere else for sand to go
      rocks << sand
      sand_count += 1
      break
    end

    if sand == [500,0]
      break
    end
  end
  break if sand == [500,0]
end
puts sand_count
