#! /usr/bin/env ruby

$debug = true

inputs = File.read('24-input.txt').split("\n")
#inputs = [
#  'sesenwnenenewseeswwswswwnenewsewsw',
#  'neeenesenwnwwswnenewnwwsewnenwseswesw',
#  'seswneswswsenwwnwse',
#  'nwnwneseeswswnenewneswwnewseswneseene',
#  'swweswneswnenwsewnwneneseenw',
#  'eesenwseswswnenwswnwnwsewwnwsene',
#  'sewnenenenesenwsewnenwwwse',
#  'wenwwweseeeweswwwnwwe',
#  'wsweesenenewnwwnwsenewsenwwsesesenwne',
#  'neeswseenwwswnwswswnw',
#  'nenwswwsewswnenenewsenwsenwnesesenew',
#  'enewnwewneswsewnwswenweswnenwsenwsw',
#  'sweneswneswneneenwnewenewwneswswnese',
#  'swwesenesewenwneswnwwneseswwne',
#  'enesenwswwswneneswsenwnewswseenwsese',
#  'wnwnesenesenenwwnenwsewesewsesesew',
#  'nenewswnwewswnenesenwnesewesw',
#  'eneswnwswnwsenenwnwnwwseeswneewsenese',
#  'neswnwewnwnwseenwseesewsenwsweewe',
#  'wseweeenwnesenwwwswnew',
#]

class Tile
  attr_accessor :position

  def initialize(position = [0,0])
    @position = position
  end

  def e
    Tile.new([position.first + 2, position.last])
  end

  def w
    Tile.new([position.first - 2, position.last])
  end

  def ne
    Tile.new([position.first + 1, position.last + 1])
  end

  def nw
    Tile.new([position.first - 1, position.last + 1])
  end

  def se
    Tile.new([position.first + 1, position.last - 1])
  end

  def sw
    Tile.new([position.first - 1, position.last - 1])
  end

  def neighbours
    [e, w, ne, nw, se, sw]
  end
end

positions = inputs.map do |i|
  directions = i.split(/(e|w|se|sw|ne|nw)/).select {|s| !s.empty?}
  current_tile = Tile.new
  directions.each do |direction|
    current_tile = current_tile.send(direction)
  end
  current_tile.position
end

def black_tiles_positions(positions)
  positions
    .reduce({}) { |acc, p| acc[p] ||= 0; acc[p] += 1; acc }
    .select { |p, count| count.odd? }.to_h
    .keys
end

puts black_tiles_positions(positions).count

def max_floor_size(black_tiles)
  min_x = black_tiles.map { |p| p.first }.min
  max_x = black_tiles.map { |p| p.first }.max
  min_y = black_tiles.map { |p| p.last }.min
  max_y = black_tiles.map { |p| p.last }.max

  if (min_x.odd? && min_y.even?) || (min_x.odd? && min_y.even?)
    min_y -= 1
  end

  if (max_x.odd? && max_y.even?) || (max_x.odd? && max_y.even?)
    max_y += 1
  end

  [(max_x + max_y)/2, (min_x.abs + min_y.abs)/2].max + 2
end

directions = %w(nw w sw se e ne)
black_tiles = black_tiles_positions(positions)

100.times do |day|
  new_black_tiles = []
  iteration = 0
  current_tile = Tile.new
  loop do # each "circle"
    #puts "Circle #{iteration}" if $debug
    new_tile = nil
    path = directions.map{|d| [d] * iteration}.flatten
    tiles = path.reduce([current_tile]) {|acc, direction| acc << acc.last.send(direction); acc }
    tiles.each do |current_tile|
      is_black = black_tiles.include?(current_tile.position)
      black_neighbours = current_tile.neighbours.select {|t| black_tiles.include?(t.position)}.size
      if is_black
        if black_neighbours == 0 || black_neighbours > 2
        else
          new_black_tiles << current_tile.position
        end
      else
        if black_neighbours == 2
          new_black_tiles << current_tile.position
        end
      end
    end
    iteration += 1
    current_tile = current_tile.e

    break if iteration == max_floor_size(black_tiles) + 1
  end
  puts "Day #{day + 1}: #{new_black_tiles.uniq.count}" if $debug
  black_tiles = new_black_tiles.uniq
end
