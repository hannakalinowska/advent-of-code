#! /usr/bin/env ruby

require_relative 'tile'
require_relative 'board'

def part_one
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
    ]
  }.flatten

  board = Board.new(tiles)
  result = board.start
  puts [
    result.positions[0][0],
    result.positions[-1][0],
    result.positions[0][-1],
    result.positions[-1][-1]
  ].map {|t| t.id.to_i}.reduce(&:*)

  write_image(result)
end

def write_image(result)
  f = File.open('20-output.txt', 'w')
  result.positions.each.with_index do |row, i|
    (1 .. row.first.tile.size - 2).each do |j|
      line = row.map {|t| t.tile[j][1 .. -2] }.join
      f.puts line
    end
  end
end

def mark_sea_monster(line, mask)
  result = []
  (0 .. line.length - 1).each do |i|
    if mask[i] == '#'
      result [i] = 'O'
    else
      result[i] = line[i]
    end
  end
  result.join
end

def part_two
  image = Tile.new("0", File.read('20-output.txt').split("\n"))

  sea_monster_plain = [
    '                  # ',
    '#    ##    ##    ###',
    ' #  #  #  #  #  #   ',
  ]

  sea_monster = sea_monster_plain.map {|row| row.gsub(' ', '.')}

  sea_monster_length = sea_monster.first.length
  found = true

  [image,
   image.rotate,
   image.rotate.rotate,
   image.rotate.rotate.rotate,
   image.flip_vertically,
   image.flip_vertically.rotate,
   image.flip_vertically.rotate.rotate,
   image.flip_vertically.rotate.rotate.rotate,
  ].each do |image|
    tile = image.tile
    found = false

    tile[0 .. -3].each.with_index do |row, i|
      (0 .. row.size - 1).each do |j|
        if row[j .. j + sea_monster_length-1] =~ /#{sea_monster[0]}/ &&
            tile[i+1][j .. j + sea_monster_length-1] =~ /#{sea_monster[1]}/ &&
            tile[i+2][j .. j + sea_monster_length-1] =~ /#{sea_monster[2]}/

            found = true

            row[j .. j + sea_monster_length-1] = mark_sea_monster(row[j .. j + sea_monster_length-1], sea_monster[0])
            tile[i+1][j .. j + sea_monster_length-1] = mark_sea_monster(tile[i+1][j .. j + sea_monster_length-1], sea_monster[1])
            tile[i+2][j .. j + sea_monster_length-1] = mark_sea_monster(tile[i+2][j .. j + sea_monster_length-1], sea_monster[2])
        end
      end
    end
    if found
      puts tile
      puts tile.map {|row| row.split('').select {|c| c=='#'}.size }.sum
      return
    end
  end
end

part_two
