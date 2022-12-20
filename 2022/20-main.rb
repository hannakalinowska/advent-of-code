#! /usr/bin/env ruby

require_relative '20/list'

input = File.read('20-input.txt')
#input = <<-EOF
#1
#2
#-3
#3
#-2
#0
#4
#EOF
input = input.split("\n").map do |n|
  [rand(1_000_000_000).to_s(16), n.to_i]
end

queue = input.dup
list = List.new(input)

loop do
  current = queue.shift
  list.move(current)

  break if queue.empty?
end

zero_index = input.map(&:last).index(0)
numbers = []
numbers << input[(zero_index + 1000) % input.length].last
numbers << input[(zero_index + 2000) % input.length].last
numbers << input[(zero_index + 3000) % input.length].last

puts numbers.reduce(:+)
