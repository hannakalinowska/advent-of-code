#! /usr/bin/env ruby

input = File.read('06-input.txt')
#input = 'bvwbjplbgvbhsrlpgdmjqwftvncz'
#input = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'

input = input.split('')

input.each_with_index do |c, i|
  four_characters = input[i .. i+3]
  if four_characters.uniq.length == 4
    puts i + 4
    break
  end
end
