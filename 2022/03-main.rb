#! /usr/bin/env ruby

input = File.read('03-input.txt')
#input = <<-EOF
#vJrwpWtwJgWrhcsFMMfFFhFp
#jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
#PmmdzqPrVvPwwTWBwg
#wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
#ttgJtRGJQctTZtZT
#CrZsJsPPZsGzwwsLwLmpwMDw
#EOF
input = input.split("\n")

priorities = (('a' .. 'z').zip(1 .. 26) + ('A' .. 'Z').zip(27 .. 52)).to_h

total = 0
input.each do |line|
  length = line.length/2
  first_half = line[0..length-1].split('')
  second_half = line[length..line.length].split('')

  shared = (first_half & second_half).first
  total += priorities[shared]
end

puts total
