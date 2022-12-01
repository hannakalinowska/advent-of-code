#! /usr/bin/env ruby

inputs = File.read('01-input.txt').split(/\n\n/)
calories_list = inputs.map { |s| s.split("\n").map(&:to_i) }
  .map { |a| a.reduce(:+) }
puts calories_list.max(3).sum
