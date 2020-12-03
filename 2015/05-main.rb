#! /usr/bin/env ruby

inputs = File.read('05-input.txt').split

def rule_one?(line)
  line.split('').select {|c| %w(a e o i u).include?(c) }.length >= 3
end

def rule_two?(line)
  line =~ /(\w)\1/
end

def rule_three?(line)
  previous = nil
  line.split('').each do |c|
    if previous && c == previous.next
      return false
    end
    previous = c
  end
  true
end

nice = inputs.select do |line|
  one = rule_one?(line)
  two = rule_two?(line)
  three = rule_three?(line)

  #if !(one && two && three)
  #  puts one.inspect, two.inspect, three.inspect
  #  puts line
  #  require 'pry'; binding.pry
  #end

  one && two && three
end

puts nice.length
