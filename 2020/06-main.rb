#! /usr/bin/env ruby

inputs = File.read('06-input.txt').split("\n\n")

sum = inputs.reduce(0) { |sum, group|
  #sum += group.gsub("\n", '').split('').uniq.count
  sum += group.split("\n").reduce(nil) { |intersection, p|
    if intersection.nil?
      p.split('')
    else
      intersection & p.split('')
    end
  }.uniq.count
}

puts sum
