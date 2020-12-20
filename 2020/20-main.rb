#! /usr/bin/env ruby

require_relative 'tile'
require_relative 'board'

inputs = File.read('20-input.txt').split("\n\n")
#inputs = File.read('20-input-test.txt').split("\n\n")
tile = inputs.first.split("\n")

tiles = inputs.map {|t|
  t = t.split("\n")
  id = t.shift.gsub(/^.+?(\d+).+?$/, '\1')
  t = Tile.new(id, t)
  [
    t,
    t.rotate,
    t.rotate.rotate,
    t.rotate.rotate.rotate,
    t.flip_vertically,
    t.flip_vertically.rotate,
    t.flip_vertically.rotate.rotate,
    t.flip_vertically.rotate.rotate.rotate,
    t.flip_horizontally,
    t.flip_horizontally.rotate,
    t.flip_horizontally.rotate.rotate,
    t.flip_horizontally.rotate.rotate.rotate,
  ]
}.flatten

board = Board.new(tiles)
result = board.start
puts [
  positions[0][0],
  positions[-1][0],
  positions[0][-1],
  positions[-1][-1]
].map {|t| t.id.to_i}.reduce(&:*)
