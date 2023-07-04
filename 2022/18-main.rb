#! /usr/bin/env ruby

input = File.read('18-input.txt')
#input = <<-EOF
#2,2,2
#1,2,2
#3,2,2
#2,1,2
#2,3,2
#2,2,1
#2,2,3
#2,2,4
#2,2,6
#1,2,5
#3,2,5
#2,1,5
#2,3,5
#EOF
input = input.split("\n")

def not_hole?(p, points)

end

def traverse_hole(p, points)

end

points = input.map do |point|
  x, y, z = point.split(',').map(&:to_i)
  [x, y, z]
end
holes = []
not_holes = []

total_open_sides = 0
points.each do |x, y, z|
  sides = 6

  [
    [x-1, y, z],
    [x+1, y, z],
    [x, y-1, z],
    [x, y+1, z],
    [x, y, z-1],
    [x, y, z+1],
  ].each do |p|
    if points.include?(p)
      # nothing - has neighbour
    elsif holes.include?(p)
      # nothing - holes don't count
    elsif not_hole?(p, points)
      # definitely an open edge
    else
      # discover
      traverse_hole(p, points)
    end
  end

  open_sides = sides - neighbours.size
  total_open_sides += open_sides
end
puts total_open_sides

#require 'pry'; binding.pry
#puts
