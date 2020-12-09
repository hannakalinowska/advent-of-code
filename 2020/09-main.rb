#! /usr/bin/env ruby

LENGTH = 25

inputs = File.read('09-input.txt').split.map(&:to_i)

def valid?(number, items)
  items.find do |i|
    items.include?(number - i)
  end
end

from = 0

loop do
  number = inputs[from + LENGTH]
  items = inputs[from, LENGTH]

  if valid?(number, items)
    from += 1
  else
    puts number
    exit
  end
end
