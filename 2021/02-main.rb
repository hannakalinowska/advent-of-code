#! /usr/bin/env ruby

lines = File.read('02-input.txt').split(/\n/)

horizontal = 0
depth = 0

lines.each do |line|
  direction, amount = line.split(" ")
  case direction
  when "forward"
    horizontal += amount.to_i
  when "down"
    depth += amount.to_i
  when "up"
    depth -= amount.to_i
  end
end

puts horizontal * depth
