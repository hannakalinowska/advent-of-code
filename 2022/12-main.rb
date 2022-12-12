#! /usr/bin/env ruby

require 'set'

input = File.read('12-input.txt')
#input =<<-EOF
#Sabqponm
#abcryxxl
#accszExk
#acctuvwj
#abdefghi
#EOF
input = input.split("\n").map {|line| line.split('')}

start_node = nil
input.each_with_index do |line, i|
  line.each_with_index do |height, j|
    if height == 'S'
      start_node = [i, j]
      break
    end
  end
end

target_node = nil
input.each_with_index do |line, i|
  line.each_with_index do |height, j|
    if height == 'E'
      target_node = [i, j]
      break
    end
  end
end

$max_i = input.length
$max_j = input.first.length

def node_index(i, j)
  "#{i},#{j}"
end

def reverse_node_index(i)
  i.split(',').map(&:to_i)
end

distances = {
  node_index(*start_node) => 0
}
previous = {}

unvisited = Set.new
(0 .. $max_i-1).each do |i|
  (0 .. $max_j-1).each do |j|
    unvisited << node_index(i, j)
  end
end

def height_difference(node1, node2)
  node1 = node1.gsub(/S/, 'a').gsub(/E/, 'z')
  node2 = node2.gsub(/S/, 'a').gsub(/E/, 'z')

  (node2.ord - node1.ord)
end

def neighbours(node, input)
  i = node[0]
  j = node[1]

  neighbours = {}
  neighbours[node_index(i-1,j)] = 1 if i-1 >= 0 &&
    height_difference(input[i][j], input[i-1][j]) <= 1
  neighbours[node_index(i+1,j)] = 1 if i+1 < $max_i &&
    height_difference(input[i][j], input[i+1][j]) <= 1
  neighbours[node_index(i,j-1)] = 1 if j-1 >= 0 &&
    height_difference(input[i][j], input[i][j-1]) <= 1
  neighbours[node_index(i,j+1)] = 1 if j+1 < $max_j &&
    height_difference(input[i][j], input[i][j+1]) <= 1

  neighbours
end

t = Time.now
loop do
  # find next min value
  min_distance = nil
  current_node = nil
  distances.each do |node, distance|
    next unless unvisited.include?(node)
    if min_distance.nil? || distance < min_distance
      min_distance = distance
      current_node = node
    end
  end

  break if current_node.nil? # yes I know this is wrong. Whatever.

  neighbours(reverse_node_index(current_node), input).each do |node, distance|
    total_distance = distance + distances[current_node].to_i
    if distances[node].nil? || distances[node] > total_distance
      distances[node] = total_distance
      previous[node] = current_node
    end
  end
  unvisited.delete(current_node)
  if unvisited.size % 1000 == 0
    puts "#{unvisited.size} (#{Time.now - t}s)"
    t = Time.now
  end
  foo = current_node
  break if unvisited.empty?
end

puts distances[node_index(*target_node)]

