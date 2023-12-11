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
  expanded_rows << line.clone
  if line.uniq == ['.']
    expanded_rows << line
  end
end

# expand columns
expanded = []
expanded_rows = expanded_rows.transpose
expanded_rows.each_with_index do |line, i|
  expanded << line.clone
  if line.uniq == ['.']
    expanded << line
  end
end
expanded = expanded.transpose

def pretty_print(array)
  array.each do |line|
    puts line.join('')
  end
end

# find galaxies
galaxies = []
expanded.each_with_index do |line, i|
  line.each_with_index do |char, j|
    if char == '#'
      galaxies << [i, j]
    end
  end
end

distances = []
galaxies.each_with_index do |g1, i|
  galaxies.each_with_index do |g2, j|
    next if g1 == g2
    distance = (g2[0] - g1[0]).abs + (g2[1] - g1[1]).abs
    #puts "Distance between #{i+1} and #{j+1}: #{distance}"
    distances << distance
  end
end

puts distances.sum/2
