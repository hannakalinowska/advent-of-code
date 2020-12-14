#! /usr/bin/env ruby

inputs = File.read('12-input.txt').split
#inputs = [
#'F10',
#'N3',
#'F7',
#'R90',
#'F11',
#]

ship = [0,0]
waypoint = [10,1]
direction = 'E'
directions = %w(E S W N)

def move(location, direction, count)
  case direction
  when 'N'
    location[1] += count
  when 'S'
    location[1] -= count
  when 'E'
    location[0] += count
  when 'W'
    location[0] -= count
  end
end

def rotate(instruction, count, waypoint)
  count = count / 90
  count.times do
    if instruction == 'R'
      waypoint = [waypoint[1], -waypoint[0]]
    else
      waypoint = [-waypoint[1], waypoint[0]]
    end
  end
  waypoint
end

inputs.each do |line|
  line =~ /(\w)(\d+)/

  instruction = $1
  count = $2.to_i

  case instruction
  when 'N', 'S', 'E', 'W'
    move(waypoint, instruction, count)
  when 'L', 'R'
    waypoint = rotate(instruction, count, waypoint)
  when 'F'
    ship[0] = ship[0] + (count * waypoint[0])
    ship[1] = ship[1] + (count * waypoint[1])
  end
  puts "[#{line}] Ship #{ship.inspect} | Waypoint #{waypoint.inspect}"
  #require 'pry'; binding.pry
end

puts ship.reduce(0) {|acc, number| acc += number.abs; acc}
require 'pry'; binding.pry

