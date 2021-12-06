#! /usr/bin/env ruby

inputs = File.read('06-input.txt').split(',').map(&:to_i)
#inputs = "3,4,3,1,2".split(',').map(&:to_i)

old_fish = inputs

80.times do |i|
  puts "#{i}: count: #{old_fish.size}"

  new_fish = []
  old_fish.map! do |f|
    if f == 0
      new_fish << 8
    end
     f < 1 ?  (f - 1) % 7 : f - 1
  end
  old_fish += new_fish
end

puts old_fish.count
