#! /usr/bin/env ruby

inputs = File.read('input.txt').split("\n").map do |line|
  line =~ /(\d+)\-(\d+)\s+(\w):\s+(\w+)/

  {
    min_number: $1.to_i,
    max_number: $2.to_i,
    character: $3,
    password: $4,
    num_occurrences: $4.split('').select {|c| c == $3 }.count,
    letters_in_positions: [$4.split('')[$1.to_i - 1], $4.split('')[$2.to_i - 1]]
  }
end

valid_inputs = inputs.count do |line|
  line[:letters_in_positions].count{ |c| c == line[:character] } == 1
end
puts valid_inputs
