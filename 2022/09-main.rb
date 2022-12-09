#! /usr/bin/env ruby

require 'set'
require_relative '09/rope'

input = File.read('09-input.txt')
#input = <<-EOF
#R 5
#U 8
#L 8
#D 3
#R 17
#D 10
#L 25
#U 20
#EOF
input = input.split("\n")


knots = (0 .. 9).map {[0, 0]}

rope = Rope.new(knots)

tail_positions = Set.new
tail_positions << [0, 0]

input.each do |move|
  direction, number = move.split(' ')
  number = number.to_i

  number.times do
    tail_position = rope.move_head(direction, 1)
    tail_positions << tail_position.dup
  end
end

#positions = tail_positions.reduce({}) { |acc, r| acc[r] ||= tail_positions.to_a.index(r); acc }

#min_x = positions.keys.map {|p| p[0]}.min - 1
#max_x = positions.keys.map {|p| p[0]}.max + 1
#min_y = positions.keys.map {|p| p[1]}.min - 1
#max_y = positions.keys.map {|p| p[1]}.max + 1

#(min_x .. max_x).each do |i|
#  (min_y .. max_y).each do |j|
#    if positions.keys.include?([i, j])
#      print positions[[i, j]]
#    else
#      print '.'
#    end
#  end
#  puts
#end

puts tail_positions.count
