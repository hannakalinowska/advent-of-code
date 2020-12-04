#! /usr/bin/env ruby

inputs = File.read('03-input.txt').split

def traverse(inputs, delta_index, step = 1)
  index = 0
  points = 0

  (0 ... inputs.length).step(step) do |i|
    line = inputs[i]
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
  traverse(inputs, 1, 2),
].reduce(&:*)

