#! /usr/bin/env ruby

input = File.read('02-input.txt').split("\n")
#input = <<-EOF
#A Y
#B X
#C Z
#EOF
#input = input.split("\n")

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

# X lose
# Y draw
# Z win
plays = {
  'A X' => 'Z',
  'A Y' => 'X',
  'A Z' => 'Y',
  'B X' => 'X',
  'B Y' => 'Y',
  'B Z' => 'Z',
  'C X' => 'Y',
  'C Y' => 'Z',
  'C Z' => 'X',
}
fixed_results = {'X' => 0, 'Y' => 3, 'Z' => 6}

score = 0
input.each do |line|
  line =~ /^(\w) (\w)$/
  shape = plays[line]
  score += shapes[shape]
  score += fixed_results[$2]
end

puts score
