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
input.each_slice(3) do |lines|
  lines.map! {|l| l.split('')}
  shared = lines[0] & lines[1] & lines[2]

  total += priorities[shared.first]
end

puts total
