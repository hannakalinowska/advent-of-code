#! /usr/bin/env ruby

input = File.read('01-input.txt').split('')
floor = 0

input.each_with_index do |move, index|
  if move == "("
    floor += 1
  else
    floor -= 1
  end

  if floor == -1
    puts index + 1
    break
  end
end
