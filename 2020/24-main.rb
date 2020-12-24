#! /usr/bin/env ruby

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

class Path
  attr_accessor :position

  def initialize(position = [0,0])
    @position = position
  end

  def e
    @position = [position.first + 2, position.last]
  end

  def w
    @position = [position.first - 2, position.last]
  end

  def ne
    @position = [position.first + 1, position.last + 1]
  end

  def nw
    @position = [position.first - 1, position.last + 1]
  end

  def se
    @position = [position.first + 1, position.last - 1]
  end

  def sw
    @position = [position.first - 1, position.last - 1]
  end
end

positions = inputs.map do |i|
  directions = i.split(/(e|w|se|sw|ne|nw)/).select {|s| !s.empty?}
  path = Path.new
  directions.each do |direction|
    path.send(direction)
  end
  path.position
end

black_tiles = positions
  .reduce({}) { |acc, p| acc[p] ||= 0; acc[p] += 1; acc }
  .select { |p, count| count.odd? }.to_h
  .keys
  .count

puts black_tiles
