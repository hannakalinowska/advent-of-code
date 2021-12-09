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

def low_point?(i, j, n, inputs)
  top(i, j, inputs) > n &&
    left(i, j, inputs) > n &&
    bottom(i, j, inputs) > n &&
    right(i, j, inputs) > n
end

basins = []
inputs.each_with_index do |row, i|
  row.each_with_index do |n, j|
    if low_point?(i, j, n, inputs)
      queue = []
      visited = Array.new(1) { Array.new }
      queue.push([i, j])
      while !queue.empty?
        a, b = queue.shift

        visited[a] ||= []
        visited[a-1] ||= []
        visited[a+1] ||= []
        visited[a][b] = 1

        queue.push([a-1, b]) if !visited.fetch(a-1, [])[b] && top(a, b, inputs) < 9
        queue.push([a, b-1]) if !visited.fetch(a, [])[b-1] && left(a, b, inputs) < 9
        queue.push([a+1, b]) if !visited.fetch(a+1, [])[b] && bottom(a, b, inputs) < 9
        queue.push([a, b+1]) if !visited.fetch(a, [])[b+1] && right(a, b, inputs) < 9
      end
      basins << visited.flatten.compact.size
    end
  end
end

puts basins.sort.reverse.take(3).reduce(&:*)
