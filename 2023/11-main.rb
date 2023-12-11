#! /usr/bin/env ruby

input = File.read('11-input.txt')
#input = <<EOF
#...#......
#.......#..
##.........
#..........
#......#...
#.#........
#.........#
#..........
#.......#..
##...#.....
#EOF

input = input.split("\n").map{|l| l.split('')}

# expand rows
expanded_rows = []
input.each_with_index do |line, i|
  if line.uniq == ['.']
    expanded_rows << i
  end
end

# expand columns
expanded_columns = []
transposed = input.transpose
transposed.each_with_index do |line, i|
  if line.uniq == ['.']
    expanded_columns << i
  end
end

def pretty_print(array)
  array.each do |line|
    puts line.join('')
  end
end

# find galaxies
galaxies = []
input.each_with_index do |line, i|
  line.each_with_index do |char, j|
    if char == '#'
      galaxies << [i, j]
    end
  end
end

distances = []
MULTIPLIER = 1_000_000
galaxies.each_with_index do |g1, i|
  galaxies.each_with_index do |g2, j|
    next if g1 == g2
    distance = (g2[0] - g1[0]).abs + (g2[1] - g1[1]).abs
    max_i = [g1[0], g2[0]].max
    min_i = [g1[0], g2[0]].min
    max_j = [g1[1], g2[1]].max
    min_j = [g1[1], g2[1]].min
    distance += expanded_rows.select {|r| min_i < r && r < max_i}.size * (MULTIPLIER-1)
    distance += expanded_columns.select {|c| min_j < c && c < max_j}.size * (MULTIPLIER-1)
    #puts "Distance between #{i+1} and #{j+1}: #{distance}"
    distances << distance
  end
end

puts distances.sum/2
