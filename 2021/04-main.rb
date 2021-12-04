#! /usr/bin/env ruby

require_relative '04-board'

inputs = File.read("04-input.txt").split("\n\n")

numbers = inputs.shift.split(',')

boards = []
inputs.each do |line|
  boards << Board.new(line)
end

boards.map do |b|
  b.play(numbers)
end

winning = boards.max {|a, b| a.moves_to_win <=> b.moves_to_win}

puts winning.score
