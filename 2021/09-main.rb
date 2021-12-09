#! /usr/bin/env ruby

inputs = File.read('09-input.txt').split("\n").map {|i| i.split('').map(&:to_i) }

def top(i, j, inputs)
  i > 0 ? inputs[i-1][j] : 99
end

def left(i, j, inputs)
  j > 0 ? inputs[i][j-1] : 99
end

def bottom(i, j, inputs)
  i < inputs.size - 1 ? inputs[i+1][j] : 99
end

def right(i, j, inputs)
  j < inputs.first.size - 1 ? inputs[i][j+1] : 99
end

sum = 0
inputs.each_with_index do |row, i|
  row.each_with_index do |n, j|
    if top(i, j, inputs) > n &&
        left(i, j, inputs) > n &&
        bottom(i, j, inputs) > n &&
        right(i, j, inputs) > n
      sum = sum + 1 + n
    end
  end
end

puts sum
