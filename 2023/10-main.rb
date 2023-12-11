#! /usr/bin/env ruby

require_relative '10/tile'

input = File.read('10-input.txt')
input = <<EOF
7-F7-
.FJ|7
SJLL7
|F--J
LJ.LJ
EOF
input = input.split("\n").map {|line| line.split('')}


start_i = nil
start_j = nil
input.each_with_index do |line, i|
  line.each_with_index do |char, j|
    if char == 'S'
      start_i = i
      start_j = j
      break
    end
  end
end

max_steps = 0
i = start_i
j = start_j

# first move manually - set previous tile
current_tile = Tile.new(i, j, input)
# figure out possible moves around
current_tile.move_up

loop do
  clockwise = clockwise.follow
  counterclockwise = counterclockwise.follow

  max_steps += 1
  break if clockwise == counterclockwise
end

puts max_steps
