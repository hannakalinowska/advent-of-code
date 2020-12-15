#! /usr/bin/env ruby

inputs = [16,1,0,18,12,14,19]
#inputs = [1,2,3] # => 27
#inputs = [3,1,2] # => 1836
#inputs = [0,3,6] # => [0, 3, 6, 0, 3, 3, 1, 0, 4, 0] # => 436

last_number = inputs.pop
next_number = nil

numbers = inputs.reduce({}) {|acc, n|
  acc[n] = inputs.rindex(n) + 1
  acc
}
iteration = inputs.length + 1

loop do
  if numbers[last_number]
    next_number = iteration - numbers[last_number]
  else
    next_number = 0
  end

  puts iteration if iteration % 1_000_000 == 0

  if iteration >= 30000000
    puts last_number
    exit
  end

  numbers[last_number] = iteration
  last_number = next_number
  iteration += 1
end
