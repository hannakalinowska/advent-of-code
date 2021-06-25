#! /usr/bin/env ruby

inputs = File.read('05-input.txt').split

def rule_one?(line)
  line.split('').select {|c| %w(a e o i u).include?(c) }.length >= 3
end

def rule_two?(line)
  line =~ /(\w)\1/
end

def rule_three?(line)
  line !~ /ab|cd|pq|xy/
end

nice = inputs.select do |line|
  one = rule_one?(line)
  two = rule_two?(line)
  three = rule_three?(line)

  one && two && three
end

puts nice.length
