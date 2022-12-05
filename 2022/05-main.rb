#! /usr/bin/env ruby

input = File.read('05-input.txt')
stacks, moves = input.split("\n\n")

new_stacks = []
stacks.each_line do |line|
  next if line =~ /\d/

  new_line = line.gsub(/\n$/, '').gsub(/    ?/, ' ').gsub(/\[(\w)\] ?/, '\1')
  new_line.split('').each_with_index do |crate, i|
    new_stacks[i] ||= []
    new_stacks[i] << crate if crate != ' '
  end
end

moves.each_line do |move|
  move =~ /move (\d+) from (\d+) to (\d+)/
  count = $1.to_i
  from = $2.to_i - 1
  to = $3.to_i - 1

  crates = new_stacks[from].shift(count)
  new_stacks[to].unshift(crates.reverse).flatten!
end

puts new_stacks.collect {|s| s.first}.join('').inspect
puts
