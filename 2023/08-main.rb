#! /usr/bin/env ruby

input = File.read('08-input.txt')
#input = <<EOF
#LLR

#AAA = (BBB, BBB)
#BBB = (AAA, ZZZ)
#ZZZ = (ZZZ, ZZZ)
#EOF
directions, input = input.split("\n\n")

network = {}

input.split("\n").each do |line|
  line =~ /^(\w+) = \((\w+), (\w+)\)/

  source = $1
  left = $2
  right = $3

  network[source] = [left, right]
end

step = 0
node = 'AAA'
loop do
  dir = directions[step % directions.length]
  node = (dir == 'L' ?  network[node].first : network[node].last)

  step += 1
  break if node == 'ZZZ'
end

puts step
