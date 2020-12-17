#! /usr/bin/env ruby

inputs = File.read('17-input.txt').split

cubes = {0 => {}}

inputs.each.with_index do |row, i|
  cubes[0][i] ||= {}
  row.split('').each.with_index do |cube, j|
    cubes[0][i][j] = cube
  end
end

def update_dimensions(cubes)
  $max_x = cubes.keys.max
  $min_x = cubes.keys.min

  $max_y = cubes.values.map {|v| v.keys.max}.max
  $min_y = cubes.values.map {|v| v.keys.min}.min

  $max_z = cubes.values.first.values.first.keys.max
  $min_z = cubes.values.first.values.first.keys.min
end

def count_active(i, j, k, cubes)
  count = 0
  (i-1 .. i+1).each do |x|
    (j-1 .. j+1).each do |y|
      (k-1 .. k+1).each do |z|
        next if x==i && y==j && z==k

        cube = cubes.fetch(x, {}).fetch(y, {}).fetch(z, '.')
        if cube == '#'
          count += 1
        end
      end
    end
  end
  count
end

def step(cubes)
  new_cubes = {}
  ($min_x - 1 .. $max_x + 1).each do |i|
    new_cubes[i] ||= {}
    plane = cubes[i] || {}
    ($min_y - 1 .. $max_y + 1).each do |j|
      new_cubes[i][j] ||= {}
      row = plane[j] || {}
      ($min_z - 1 .. $max_z + 1).each do |k|
        active = count_active(i, j, k, cubes)
        cube = row[k]

        if active == 3
          new_cubes[i][j][k] = '#'
        elsif active == 2 && cube == '#'
          new_cubes[i][j][k] = '#'
        else
          new_cubes[i][j][k] = '.'
        end
      end
    end
  end
  new_cubes
end

update_dimensions(cubes)
6.times do
  cubes = step(cubes)
  update_dimensions(cubes)
end

count = 0
cubes.values.each do |plane|
  plane.values.each do |row|
    row.values.each do |cube|
      count += 1 if cube == '#'
    end
  end
end
puts count
