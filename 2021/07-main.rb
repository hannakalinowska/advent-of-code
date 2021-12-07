#! /usr/bin/env ruby

inputs = File.read('07-input.txt').split(',').map(&:to_i)
#inputs = '16,1,2,0,4,2,7,1,2,14'.split(',').map(&:to_i)

fuel = {}

0.upto(inputs.max) do |i|
  fuel[i] = inputs.reduce(0) {|acc, n| acc + (i - n).abs}
end

puts fuel.key(fuel.values.min)

require 'pry'; binding.pry
puts
