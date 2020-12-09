#! /usr/bin/env ruby

NUMBER = 21806024

inputs = File.read('09-input.txt').split.map(&:to_i)

from = 0
length = 1

loop do
  items = inputs[from, length]
  sum = items.reduce(&:+)

  case
  when sum == NUMBER
    puts items.max + items.min
    exit
  when sum > NUMBER
    from += 1
    length -= 1
  when sum < NUMBER
    length += 1
  end
end
