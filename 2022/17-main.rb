#! /usr/bin/env ruby

require_relative '17/tetris'
require 'set'

input = File.read('17-input.txt')
#input = <<-EOF
#>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>
#EOF
input = input.strip.split('')

# shapes:
# ####
#
# .#.
# ###
# .#.
#
# ..#
# ..#
# ###
#
# #
# #
# #
# #
#
# ##
# ##

def pretty_print(current_shape, rocks)
  max_y = current_shape.position.map {|p| p.last}.max
  min_y = [0, max_y - 20].max

  max_y.downto(min_y).each do |y|
    print '|'
    (0 .. 6).each do |x|
      if current_shape.position.include?([x, y])
        print '@'
      elsif rocks.include?([x, y])
        print '#'
      else
        print '.'
      end
    end
    print '|'
    puts
  end
end


column_heights = [0, 0, 0, 0, 0, 0, 0]
highest_column = column_heights.max
rocks = Set.new

shape_count = 0
move_index = 0
shapes = [HLine, Cross, Shelf, VLine, Square]
current_shape = shapes[shape_count % 5].new(highest_column + 4)

loop do
  move = input[move_index % input.length]
  move_index += 1
  position = current_shape.position
  case move
  when '<'
    position = current_shape.try_left
  when '>'
    position = current_shape.try_right
  end
  if position.all? {|point| point.first >= 0 && point.first <= 6} &&
      position.all? {|point| !rocks.include?(point)}
    current_shape.set_position(position)
  end

  position = current_shape.try_down
  if position.all? {|point| point.last > 0} &&
      position.all? {|point| !rocks.include?(point)}
    # Shape above current top
    current_shape.set_position(position)
  else
    # Shape hit the previous layer
    current_shape.position.each do |point|
      column_heights[point.first] = [point.last, column_heights[point.first]].max
      highest_column = column_heights.max
    end
    # get new shape
    shape_count += 1
    current_shape.position.each {|p| rocks << p}
    current_shape = shapes[shape_count % 5].new(highest_column + 4)
  end
  break if shape_count == 2022
end
puts highest_column
