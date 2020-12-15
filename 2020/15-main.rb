#! /usr/bin/env ruby

inputs = [16,1,0,18,12,14,19]
#inputs = [3,1,2]

last_number = inputs.pop

loop do
  if inputs.include?(last_number)
    next_number = inputs.length - inputs.rindex(last_number)
  else
    next_number = 0
  end

  inputs << last_number
  last_number = next_number

  break if inputs.length == 2020
end

puts inputs.last
