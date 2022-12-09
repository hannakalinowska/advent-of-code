#! /usr/bin/env ruby

require 'set'
require_relative '09/rope'

input = File.read('09-input.txt')
#input = <<-EOF
#R 4
#U 4
#L 3
#D 1
#R 4
#D 1
#L 5
#R 2
#EOF
input = input.split("\n")

head = [0, 0]
tail = [0, 0]

rope = Rope.new(head, tail)
tail_positions = Set.new
tail_positions << tail

input.each do |move|
  direction, number = move.split(' ')
  number = number.to_i

  number.times do
    tail_position = rope.move_head(direction, 1)
    tail_positions << tail_position
  end
end

puts tail_positions.count
