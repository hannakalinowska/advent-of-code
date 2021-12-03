#! /usr/bin/env ruby

inputs = File.read('03-input.txt').split(/\n/).map {|line| line.split("") }
inputs = inputs.transpose

gamma = ""
epsilon = ""

inputs.each do |line|
  count = line.reduce({'0' => 0, '1' => 0}) {|acc, l| acc[l] += 1; acc}
  gamma << count.max {|a,b| a.last <=> b.last }.first
  epsilon << count.min {|a,b| a.last <=> b.last }.first
end

puts gamma.to_i(2) * epsilon.to_i(2)
