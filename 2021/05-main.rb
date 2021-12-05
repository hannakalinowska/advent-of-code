#! /usr/bin/env ruby
require_relative '05-board'

inputs = File.read('05-input.txt').split(/\n/)
#inputs = "0,9 -> 5,9
#8,0 -> 0,8
#9,4 -> 3,4
#2,2 -> 2,1
#7,0 -> 7,4
#6,4 -> 2,0
#0,9 -> 2,9
#3,4 -> 1,4
#0,0 -> 8,8
#5,5 -> 8,2".split(/\n/)

board = Board.parse(inputs)

puts board.overlapping_count
