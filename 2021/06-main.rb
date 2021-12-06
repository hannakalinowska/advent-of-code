#! /usr/bin/env ruby

inputs = File.read('06-input.txt').split(',').map(&:to_i)
#inputs = "3,4,3,1,2".split(',').map(&:to_i)

default = {
  0 => 0,
  1 => 0,
  2 => 0,
  3 => 0,
  4 => 0,
  5 => 0,
  6 => 0,
  7 => 0,
  8 => 0,
}

counts = inputs.reduce(default) { |acc, i|
  acc[i] += 1
  acc
}

256.times do |i|
  tmp = counts[0]
  counts[0] = counts[1]
  counts[1] = counts[2]
  counts[2] = counts[3]
  counts[3] = counts[4]
  counts[4] = counts[5]
  counts[5] = counts[6]
  counts[6] = counts[7] + tmp
  counts[7] = counts[8]
  counts[8] = tmp
end

puts counts.values.sum
