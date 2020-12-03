#! /usr/bin/env ruby

inputs = File.read('03-input.txt').split

def traverse(inputs, delta_index)
  index = 0
  points = 0

  inputs.each do |line|
    current = line[index]
    points += 1 if current == '#'
    index = (index + delta_index) % line.length
  end

  return points
end

i = 0
puts [
  traverse(inputs, 1),
  traverse(inputs, 3),
  traverse(inputs, 5),
  traverse(inputs, 7),
  traverse(inputs.select { |_| i+=1; i % 2 ==1 } , 1),
].reduce(&:*)

