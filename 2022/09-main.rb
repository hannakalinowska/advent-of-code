#! /usr/bin/env ruby

require 'set'
require_relative '09/rope'

input = File.read('09-input.txt')
input = <<-EOF
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
EOF
input = input.split("\n")

def pretty_print(ropes)
  positions = ropes.reduce({}) { |acc, r| acc[r.head] ||= ropes.index(r); acc }

  min_x = positions.keys.map {|p| p[0]}.min - 1
  max_x = positions.keys.map {|p| p[0]}.max + 1
  min_y = positions.keys.map {|p| p[1]}.min - 1
  max_y = positions.keys.map {|p| p[1]}.max + 1

  (min_x .. max_x).each do |i|
    (min_y .. max_y).each do |j|
      if positions.keys.include?([i, j])
        print positions[[i, j]]
      else
        print '.'
      end
    end
    puts
  end
end

head = [0, 0]
tail = [0, 0]

ropes = 10.times.map { Rope.new(head, tail)}

tail_positions = Set.new
tail_positions << tail

input.each do |move|
  direction, number = move.split(' ')
  number = number.to_i

  number.times do
    tail_position = ropes.first.move_head(direction, 1)
    ropes[1..-1].each do |rope|
      # TODO: I think this is the problem - you can't just set the head like this
      # But I don't have a better idea
      rope.head = tail_position
      tail_position = rope.move_tail
    end
    tail_positions << tail_position
    puts "===================="
    puts move
    pretty_print(ropes)
  end
end

min_x = tail_positions.map {|p| p[0]}.min
max_x = tail_positions.map {|p| p[0]}.max
min_y = tail_positions.map {|p| p[1]}.min
max_y = tail_positions.map {|p| p[1]}.max

require 'pry'; binding.pry
(min_x .. max_x).each do |i|
  (min_y .. max_y).each do |j|
    if tail_positions.include?([i, j])
      print '#'
    else
      print '.'
    end
  end
  puts
end


puts tail_positions.count
