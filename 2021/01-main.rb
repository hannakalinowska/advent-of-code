#! /usr/bin/env ruby

inputs = File.read('01-input.txt').split.map(&:to_i)
prev_number = nil
count = 0

inputs.each do |number|
  count += 1 if !prev_number.nil? && number > prev_number
  prev_number = number
end

prev_sum = nil
count = 0
(0 .. inputs.length - 3).each do |start|
  sum = inputs[start .. start + 2].sum

  count += 1 if !prev_sum.nil? && sum > prev_sum
  prev_sum = sum
end

puts count
