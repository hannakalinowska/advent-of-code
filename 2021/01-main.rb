#! /usr/bin/env ruby

inputs = File.read('01-input.txt').split.map(&:to_i)
prev_number = nil
count = 0

inputs.each do |number|
  count += 1 if !prev_number.nil? && number > prev_number
  prev_number = number
end

puts count
