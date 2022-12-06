#! /usr/bin/env ruby

input = File.read('06-input.txt')
#input = 'bvwbjplbgvbhsrlpgdmjqwftvncz'
#input = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'

input = input.split('')
LENGTH = 14

input.each_with_index do |c, i|
  four_characters = input[i .. i+LENGTH-1]
  if four_characters.uniq.length == LENGTH
    puts i + LENGTH
    break
  end
end
