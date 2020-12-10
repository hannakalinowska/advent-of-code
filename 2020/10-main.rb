#! /usr/bin/env ruby

inputs = File.read('10-input.txt').split.map(&:to_i)

inputs << 0
inputs << (inputs.max + 3)

inputs.sort!

diffs = (1 .. inputs.size - 1).reduce({}) do |acc, i|
  diff = inputs[i] - inputs[i-1]

  acc[diff] ||= 0
  acc[diff] += 1
  acc
end

puts diffs.inspect
puts diffs[1]*diffs[3]
