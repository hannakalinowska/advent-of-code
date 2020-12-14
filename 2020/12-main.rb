#! /usr/bin/env ruby

inputs = File.read('12-input.txt').split
#inputs = [
#'F10',
#'N3',
#'F7',
#'R90',
#'F11',
#]

location = [0,0]
direction = 'E'
directions = %w(E S W N)

def move(location, direction, count)
  case direction
  when 'N'
    location[0] += count
  when 'S'
    location[0] -= count
  when 'E'
    location[1] += count
  when 'W'
    location[1] -= count
  end
end

def rotate(instruction, count, direction, directions)
  count = count / 90
  current_direction = directions.index(direction)

  case instruction
  when 'R'
    i = (current_direction + count) % 4
    directions[i]
  when 'L'
    i = (current_direction - count) % 4
    directions[i]
  end
end

inputs.each do |line|
  line =~ /(\w)(\d+)/

  instruction = $1
  count = $2.to_i

  case instruction
  when 'N', 'S', 'E', 'W'
    move(location, instruction, count)
  when 'L', 'R'
    direction = rotate(instruction, count, direction, directions)
  when 'F'
    move(location, direction, count)
  end
end

puts location.reduce(0) {|acc, number| acc += number.abs; acc}
require 'pry'; binding.pry

