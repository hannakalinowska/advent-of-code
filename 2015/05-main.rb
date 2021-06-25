#! /usr/bin/env ruby

inputs = File.read('05-input.txt').split

def rule_one?(line)
  line =~ /(\w\w).*\1/
end

def rule_two?(line)
  line =~ /(\w).\1/
end

nice = inputs.select do |line|
  one = rule_one?(line)
  two = rule_two?(line)

  one && two
end

puts nice.length
