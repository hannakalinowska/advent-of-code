#! /usr/bin/env ruby

input = File.read('15-input.txt')
input = <<-EOF
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581
EOF
input = input.split("\n").map {|s| s.split('').map(&:to_i)}
tile_size = input.length

input.each do |line|
  new_line = line.dup
  4.times do
    new_line = new_line.map {|n| n + 1 > 9 ? 1 : n + 1}
    line << new_line
    line.flatten!
  end
end

(4 * tile_size).times do
  line = input[-tile_size]
  new_line = line.map {|n| n + 1 > 9 ? 1 : n + 1}
  input << new_line
end

$max_i = input.length
$max_j = input.first.length

def node_index(i, j)
  i * $max_i + j
end

def reverse_node_index(i)
  [i / $max_i, i % $max_i]
end

distances = {
  node_index(0,0) => 0
}
previous = {}

unvisited = Set.new
(0 .. input.length-1).each do |i|
  (0 .. input.first.length-1).each do |j|
    unvisited << node_index(i, j)
  end
end

def neighbours(node, input)
  i = node[0]
  j = node[1]

  neighbours = {}
  neighbours[node_index(i-1,j)] = input[i-1][j] if i-1 >= 0
  neighbours[node_index(i+1,j)] = input[i+1][j] if i+1 < $max_i
  neighbours[node_index(i,j-1)] = input[i][j-1] if j-1 >= 0
  neighbours[node_index(i,j+1)] = input[i][j+1] if j+1 < $max_j

  neighbours
end

t = Time.now
loop do
  # find next min value
  min_distance = nil
  current_node = nil
  distances.each do |node, distance|
    next unless unvisited.include?(node)
    #next unless unvisited.index(node)
    #next if (unvisited & [node]).empty?
    if min_distance.nil? || distance < min_distance
      min_distance = distance
      current_node = node
    end
  end

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
  break if unvisited.empty?
end

# example: 40
target_node = node_index(input.length-1, input.first.length-1)
puts distances[target_node]
