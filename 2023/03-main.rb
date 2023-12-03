#! /usr/bin/env ruby

require_relative '03/parser'

input = File.read('03-input.txt')
#input =<<EOF
#467..114..
#...*......
#..35..633.
#......#...
#617*......
#.....+.58.
#..592.....
#......755.
#...$.*....
#.664.598..
#EOF
input = input.split("\n")

class Part
  def initialize(symbol:, numbers: [])
    @symbol = symbol
    @numbers = numbers
  end
end

part_numbers = []

input.each_with_index do |line, i|
  line.split('').each_with_index do |char, j|
    if char =~ /[^.\d\n]/
      part_numbers << Parser.up(i, j, input)
      part_numbers << Parser.down(i, j, input)
      part_numbers << Parser.left(i, j, input)
      part_numbers << Parser.right(i, j, input)
    end
  end
end

puts part_numbers.flatten.sum
