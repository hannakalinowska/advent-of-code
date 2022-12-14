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

# Where are the lowest rocks?
lowest_rocks = rocks.map(&:last).max

# sand falls
sand_count = 0
loop do
  sand = [500, 0]
  loop do
    if !rocks.include?([sand[0], sand[1]+1])
      sand = [sand[0], sand[1]+1]
    elsif !rocks.include?([sand[0]-1, sand[1]+1])
      sand = [sand[0]-1, sand[1]+1]
    elsif !rocks.include?([sand[0]+1, sand[1]+1])
      sand = [sand[0]+1, sand[1]+1]
    else
      # nowhere else for sand to go
      rocks << sand
      sand_count += 1
      break
    end

    if sand[1] > lowest_rocks
      break
    end
  end
  break if sand[1] > lowest_rocks
end
puts sand_count
