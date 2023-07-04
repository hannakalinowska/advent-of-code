#! /usr/bin/env ruby

require 'set'

input = File.read('19-input.txt')
input = File.read('19-sample.txt')
input = input.split("\n\n")

def rotate_x(degrees, coordinates)
  x, y, z = coordinates
  {
    0   => [x, y, z],
    90  => [x, -z, y],
    180 => [x, -y, -z],
    270 => [x, z, -y],
  }.fetch(degrees)
end

def rotate_y(degrees, coordinates)
  x, y, z = coordinates
  {
    0   => [x, y, z],
    90  => [z, y, -x],
    180 => [-x, y, -z],
    270 => [-z, y, x],
  }.fetch(degrees)
end

def rotate_z(degrees, coordinates)
  x, y, z = coordinates
  {
    0   => [x, y, z],
    90  => [-y, x, z],
    180 => [-x, -y, z],
    270 => [y, -x, z],
  }.fetch(degrees)
end

beacons = []

input.each_with_index do |chunk, scanner|
  beacons[scanner] = []
  coordinates = chunk.split("\n")[1 .. -1]

  coordinates.each do |line|
    x, y, z = line.split(',').map(&:to_i)
    beacon = Set.new

    [0, 90, 180, 270].each do |x_rotation|
      [0, 90, 180, 270].each do |y_rotation|
        [0, 90, 180, 270].each do |z_rotation|
           coords = rotate_z(z_rotation, rotate_y(y_rotation, rotate_x(x_rotation, [x, y, z])))
           beacon << coords
           #puts coords.inspect
        end
      end
    end

    beacons[scanner] << beacon.sort
  end
end


# booooo
# count distances between all the beacons instead, compare that

beacons.each do |scanner1|
  beacons.each do |scanner2|
    require 'pry'; binding.pry
  end
end

require 'pry'; binding.pry
puts
