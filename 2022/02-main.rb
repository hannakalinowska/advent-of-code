#! /usr/bin/env ruby

input = File.read('02-input.txt').split("\n")

# A X Rock
# B Y Paper
# C Z Scissors

shapes = {'X' => 1, 'Y' => 2, 'Z' => 3}
results = {
  'A X' => 3,
  'A Y' => 6,
  'A Z' => 0,
  'B X' => 0,
  'B Y' => 3,
  'B Z' => 6,
  'C X' => 6,
  'C Y' => 0,
  'C Z' => 3,
}

score = 0
input.each do |line|
  line =~ /^(\w) (\w)$/
  score += shapes[$2]
  score += results[line]
end

puts score
