#! /usr/bin/env ruby

inputs = File.read('01-input.txt').split(/\n\n/)
puts inputs.map { |s| s.split("\n").map(&:to_i) }
  .map { |a| a.reduce(:+) }
  .max
